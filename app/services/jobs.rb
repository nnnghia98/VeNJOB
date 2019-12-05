require "csv"
require "activerecord-import"
# require "activerecord -import/active_record/adapters/mysql_adapter"

class JobImport
  def jobs
    jobs = []
    columns = [:title, :level, :salary, :description, :short_des, :requirement,
               :category, :company_id]

    CSV.foreach(Rails.root.join("lib", "jobss.csv"), headers: true) do |row|
      jobs << {title: row["name"], level: row["level"], salary: row["salary"],
               description: row["description"], short_des: row["benefit"],
               requirement: row["requirement"], category: row["type"],
               company_id: Company.find_by(code: row["company id"])&.id}
    end

    Job.import columns, jobs
  end
end
