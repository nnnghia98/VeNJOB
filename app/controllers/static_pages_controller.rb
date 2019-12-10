class StaticPagesController < ApplicationController
  def index
    @cities = City.page(params[:page]).per(Settings.col.page.per)
    @industries = Industry.page(params[:page]).per(Settings.col.page.per)
    @jobs = Job.page(params[:page]).per(Settings.table.page.per)
  end
end
