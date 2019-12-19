class TopsController < ApplicationController
  def index
    @vn_cities = City.city_order.take(Settings.top.city.limit)
    @industries = Industry.industry_order.take(Settings.top.city.limit)
    @jobs = Job.latest_job
  end
end
