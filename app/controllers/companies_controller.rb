class CompaniesController < ApplicationController
  def index
    @companies = Company.all
  end

  def import
    Company.companies_import
  end
end
