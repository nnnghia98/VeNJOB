# In database
#   t.string :title
#   t.string :level
#   t.string :salary
#   t.string :other_salary
#   t.text :description
#   t.text :short_des
#   t.text :requirement
#   t.integer :category
#   t.datetime :post_date
#   t.datetime :expiration_date
#   t.references :company, null: false, foreign_key: true

require "csv"
require "activerecord-import"
# require "activerecord -import/active_record/adapters/mysql_adapter"

class Job < ApplicationRecord
  belongs_to :company

  def self.jobs_import
    jobs = []
    columns = [:title, :level, :salary, :description, :short_des, :requirement, :category]

    CSV.foreach(Rails.root.join("lib", "jobss.csv"), headers: true) do |row|
      jobs << {title: row["name"], level: row["level"], salary: row["salary"], description: row["description"], short_des: row["benifit"], requirement: row["requirement"], category: row["type"]}
    end

    Job.import columns, jobs
  end
end
