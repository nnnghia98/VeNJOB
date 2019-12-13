require "csv"

class JobsImport
  def import_job
    jobs = []
    job_columns = [:title, :level, :salary, :description, :short_des,
                   :requirement, :category, :company_id]
    city_jobs = []
    CSV.foreach(Rails.root.join("lib", "jobss.csv"), headers: true) do |row|
      job_csv = JobCsv.new(row)
      jobs << job_csv.csv_attributes
      city_jobs << [row["company province"], job_csv.title, job_csv.company_id]
    end

    Job.import job_columns, jobs
    puts "Jobs imported"

    city_jobs.each do |city_name, job_title, company_id|
      job = Job.find_by(title: job_title, company_id: company_id)
      city = City.find_by(name: city_name)
      job.city_jobs.create(city_id: city.id)
    end
  end
end
