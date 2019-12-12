class JobsController < ApplicationController
  def index
    @jobs = Job.page(params[:page]).per(Settings.job.per_page)
  end
end
