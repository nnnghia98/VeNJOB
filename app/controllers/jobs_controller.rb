class JobsController < ApplicationController
  def index
    @jobs = Job.page(params[:page]).per(Settings.job.per_page)
  end

  def show
    @job = Job.find(params[:id])
  end
end
