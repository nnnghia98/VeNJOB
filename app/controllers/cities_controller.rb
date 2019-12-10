class CitiesController < ApplicationController
  def index
    @cities = City.page(params[:page]).per(Settings.col.page.per)
  end
end
