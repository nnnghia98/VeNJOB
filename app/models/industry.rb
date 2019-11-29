# In db
# t.string :name

require "csv"
require "activerecord-import"
# require "activerecord -import/active_record/adapters/mysql_adapter"

class Industry < ApplicationRecord
  def self.industries_import
    industries = []
    columns = [:name]

    CSV.foreach(Rails.root.join("lib", "jobss.csv"), headers: true) do |row|
      industries << {name: row["category"]}
    end

    Industry.import columns, industries, on_duplicate_key_ignore: true
  end
end
