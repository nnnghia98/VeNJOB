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
end
