class IndustriesController < ApplicationController
  def index
    @industries = Industry.all
  end

  def import
    Industry.industries_import
  end
end
