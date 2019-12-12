class StaticPagesController < ApplicationController
  def index
    @vn_cities = City.vn_cities
    @industries  = Industry.all
    @jobs = Job.page(params[:page]).per(Settings.job.per_page)
  end
end
