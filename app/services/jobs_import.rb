require "csv"

class JobsImport
  def import_job
    jobs = []
    job_columns = [:title, :level, :salary, :description, :short_des,
                   :requirement, :category, :company_id]

    CSV.foreach(Rails.root.join("lib", "jobss.csv"), headers: true) do |row|
      jobs << JobCsv.new(row).csv_attributes
    end

    Job.import job_columns, jobs
    puts "Jobs imported"
  end
end
