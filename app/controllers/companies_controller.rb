class CompaniesController < ApplicationController
  def index
    @companies = Company.all
  end

  def import
    Company.companies_import
    redirect_to companies_index_path
  end
end
