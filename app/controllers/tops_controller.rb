class TopsController < ApplicationController
  def index
    @vn_cities = City.city_order.take(Settings.top.city.limit)
    @industries  = Industry.all
    @jobs = Job.page(params[:page]).per(Settings.job.per_page)
  end
end
