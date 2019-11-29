class StaticPagesController < ApplicationController
  def top_page
    @cities = City.all
    @industries = Industry.all
  end

  def favorite
  end

  def history
  end
end
