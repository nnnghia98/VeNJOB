class JobsController < ApplicationController
  before_action :authenticate_user!, only: [:apply, :confirm_apply, :finish_apply]
  before_action :find_user, only: :apply_available
  before_action :validate_city_industry, only: :index
  before_action :find_applied_jobs, only: [:apply, :confirm_apply, :finish_apply]

  def index
    @search = params
    solr = SolrService.new(@search)

    if params[:city_id]
      @jobs = solr.query_by_city["docs"]
      @jobs_count = solr.query_by_city["numFound"]
    elsif params[:industry_id]
      @jobs = solr.query_by_industry["docs"]
      @jobs_count = solr.query_by_industry["numFound"]
    else
      @jobs = solr.query_all["docs"]
      @jobs_count = solr.query_all["numFound"]
    end

    @jobs = Kaminari.paginate_array(@jobs).page(params[:page]).per(Settings.job.per_page)
  end

  def show
    @job = Job.find(params[:id]).decorate
  end

  def apply
    redirect_to new_user_session_path unless user_signed_in?
    redirect_to jobs_path if params[:job_id].blank?
    @job_id = params[:job_id]
  end

  def confirm_apply

  end

  def finish_apply
    @apply_info = params[:confirm_apply_info]
    @job_id = params[:confirm_apply_info][:job_id]

    if params[:commit] == "Edit"
      redirect_to apply_path(job_id: @job_id, params: confirm_apply_info_params)
    else
      @all_applied_jobs.find_by(job_id: @job_id) ||
      @all_applied_jobs.create!(user_id: current_user.id, job_id: @job_id, applied_at: Time.current)
    end
  end

  def apply_available
    user_jobs.find_by(job_id: @job_id, user_id: @user.id)
  end

  private

  def confirm_apply_info_params
    params.require(:confirm_apply_info).permit(:job_id, :first_name, :last_name, :email)
  end

  def find_user
    @user = User.find_by(:id)
  end

  def validate_city_industry
    if params[:city_id]
      redirect_to jobs_path unless City.find_by(id: params[:city_id])
    elsif params[:industry_id]
      redirect_to jobs_path unless Industry.find_by(id: params[:industry_id])
    end
  end

  def find_applied_jobs
    @all_applied_jobs = current_user.user_jobs.where.not(applied_at: nil)
  end
end
