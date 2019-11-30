class IndustriesController < ApplicationController
  def index
    @industries = Industry.all
  end

  def import
    Industry.industries_import
    redirect_to root_path, notice: "Industries imported successful!"
  end
end
