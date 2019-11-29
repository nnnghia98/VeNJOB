class CitiesController < ApplicationController
  def index
    @cities = City.all
  end

  def import
    City.cities_import
  end
end
