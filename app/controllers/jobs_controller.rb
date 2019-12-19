class JobsController < ApplicationController
  def index
    @jobs = Job.page(params[:page]).per(Settings.job.per_page).decorate
  end

  def show
    @job = Job.find(params[:id]).decorate
  end
end
