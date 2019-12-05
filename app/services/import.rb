require "csv"
require "activerecord-import"
# require "activerecord -import/active_record/adapters/mysql_adapter"

class Import
  def import
    cities = []
    companies = []
    industries = []
    jobs = []

    city_columns = [:name, :region]
    company_columns = [:name, :email, :address, :code]
    industry_columns = [:name]
    job_columns = [:title, :level, :salary, :description, :short_des, :requirement,
      :category, :company_id]

    CSV.foreach(Rails.root.join("lib", "jobss.csv"), headers: true) do |row|
      cities << {name: row["company province"], region: "Việt Nam"}
      companies << {name: row["company name"], email: row["contact email"],
        address: row["company address"], code: row["company id"]}
      industries << {name: row["category"]}
      jobs << {title: row["name"], level: row["level"], salary: row["salary"],
        description: row["description"], short_des: row["benefit"],
        requirement: row["requirement"], category: row["type"],
        company_id: Company.find_by(code: row["company id"])&.id}
    end

    City.import city_columns, cities, on_duplicate_key_ignore: true
    Company.import company_columns, companies, on_duplicate_key_ignore: true
    Industry.import industry_columns, industries, on_duplicate_key_ignore: true
    Job.import job_columns, jobs
  end
end
