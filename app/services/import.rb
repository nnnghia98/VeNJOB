require "csv"

class Import
  def initialize()
  end

  def import
    cities = []
    companies = []
    industries = []
    jobs = []

    city_columns = [:name, :region]
    company_columns = [:name, :email, :address, :code]
    industry_columns = [:name]
    job_columns = [:title, :level, :salary, :description, :short_des,
                   :requirement, :category, :company_id]

    join_jobs = []

    file_path = Settings.csv.file_path

    CSV.foreach(Rails.root.join("lib", file_path), headers: true) do |row|
      cities << {name: row["company province"], region: "Việt Nam"}
      companies << {name: row["company name"], email: row["contact email"],
        address: row["company address"], code: row["company id"]}
      industries << {name: row["category"]}
      job_csv = JobCsv.new(row)
      jobs << job_csv.csv_attributes
      join_jobs << [row["company province"], row["category"], job_csv.title, job_csv.company_id]

      rescue
        error = ActiveSupport::Logger.new("log/errors.log")
        error.info "These row have been skipped: #{row}"
        next
    end

    cities_import(city_columns, cities)
    industries_import(industry_columns, industries)
    companies_import(company_columns, companies)
    jobs_import(job_columns, jobs)
    join_jobs_import(join_jobs)
  end

  def cities_import(col_arr, arr)
    return if col_arr.blank?
    City.import col_arr, arr, on_duplicate_key_ignore: true
  end

  def industries_import(col_arr, arr)
    return if col_arr.blank?
    Industry.import col_arr, arr, on_duplicate_key_ignore: true
  end

  def companies_import(col_arr, arr)
    return if col_arr.blank?
    Company.import col_arr, arr, on_duplicate_key_ignore: true
  end

  def jobs_import(col_arr, arr)
    return if col_arr.blank?
    Job.import col_arr, paraarrm2
  end

  def join_jobs_import(param)
    param.each do |city_name,industry_name, job_title, company_id|
      job = Job.find_by(title: job_title, company_id: company_id)
      city = City.find_by(name: city_name)
      job.city_jobs.create(city_id: city.id)
      industry = Industry.find_by(name: industry_name)
      job.industry_jobs.create(industry_id: industry.id)
    end
  end
end
