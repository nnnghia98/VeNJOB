class StaticPagesController < ApplicationController
  def index
    @cities = City.page(params[:page]).per(Settings.city.per_page)
    @industries  = Industry.all
    @jobs = Job.page(params[:page]).per(Settings.job.per_page)
  end
end
