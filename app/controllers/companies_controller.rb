class CompaniesController < ApplicationController
  def index
    @companies = Company.page(params[:page]).per(Settings.table.page.per)
  end
end
