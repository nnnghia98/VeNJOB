class CitiesController < ApplicationController
  def index
    @cities = City.page(params[:page]).per(Settings.city.per_page)
  end
end
