class CitiesController < ApplicationController
  def index
    @vn_cities = City.vn_cities
    @inter_cities = City.inter_cities
  end
end
