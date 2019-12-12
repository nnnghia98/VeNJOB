class StaticPagesController < ApplicationController
  def index
    @cities = City.all
    @industries  = Industry.all
    @jobs = Job.page(params[:page]).per(Settings.job.per_page)
  end
end
