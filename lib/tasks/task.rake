require "./app/services/cities.rb"
require "./app/services/industries.rb"
require "./app/services/companies.rb"
require "./app/services/jobs.rb"

namespace :task do
  desc "import data"
  task import: :environment do
    CityImport.new.cities
    CompanyImport.new.companies
    IndustryImport.new.industries
    JobImport.new.jobs
  end
end
