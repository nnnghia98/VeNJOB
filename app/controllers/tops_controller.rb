class TopsController < ApplicationController
  def index
    @vn_cities = City.city_order
    @industries = Industry.industry_order
    @latest_jobs = Job.latest_job
  end
end
