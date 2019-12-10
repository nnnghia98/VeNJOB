class JobsController < ApplicationController
  def index
    @jobs = Job.page(params[:page]).per(Settings.table.page.per)
  end
end
