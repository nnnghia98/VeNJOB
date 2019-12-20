class JobsController < ApplicationController
  def index
    if params[:city_id]
      redirect_to jobs_path if params[:city_id].blank?
      @city_name = City.find(params[:city_id])
      @jobs = @city_name.jobs
    elsif params[:industry_id]
      redirect_to jobs_path if params[:industry_id].blank?
      @industry_name = Industry.find(params[:industry_id])
      @jobs = @industry_name.jobs
    else
      @jobs = Job.all
    end

    @jobs = @jobs.page(params[:page]).per(Settings.job.per_page).decorate
  end

  def show
    @job = Job.find(params[:id]).decorate
  end
end
