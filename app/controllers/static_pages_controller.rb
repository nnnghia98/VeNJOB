class StaticPagesController < ApplicationController
  def index
    @cities = City.all
    @industries  = Industry.all
    @jobs = Job.page(params[:page]).per(5)
  end
end
