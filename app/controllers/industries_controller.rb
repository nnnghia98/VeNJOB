class IndustriesController < ApplicationController
  def index
    @industries = Industry.page(params[:page]).per(Settings.col.page.per)
  end
end
