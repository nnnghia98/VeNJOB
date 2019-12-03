class StaticPagesController < ApplicationController
  def top_page
    @cities = City.all
    @industries = Industry.all
    @jobs = Job.page params[:page]
  end

  def favorite
  end

  def history
  end
end
