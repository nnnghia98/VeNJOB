class JobsController < ApplicationController
  def index
    if params[:city_id]
      @city = City.find(params[:city_id])
      @jobs = @city.jobs
    elsif params[:industry_id]
      @industry = Industry.find(params[:industry_id])
      @jobs = @industry.jobs
    else
      @jobs = Job.all
    end

    @jobs = @jobs.page(params[:page]).per(Settings.job.per_page).decorate
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
      current_user.user_jobs.find_by(user_id: current_user.id, job_id: @job_id) ||
      current_user.user_jobs.create!(user_id: current_user.id, job_id: @job_id, applied_at: Time.current)
    end
  end

  private

  def confirm_apply_info_params
    params.require(:confirm_apply_info).permit(:job_id, :first_name, :last_name, :email)
  end
end
