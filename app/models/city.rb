# In database
#   t.string :name, unique: true
#   t.string :region

require "csv"
require "activerecord-import"
# require "activerecord -import/active_record/adapters/mysql_adapter"


class City < ApplicationRecord
  def self.cities_import
    cities = []
    columns = [:name, :region]

    CSV.foreach(Rails.root.join("lib", "jobss.csv"), headers: true) do |row|
      cities << {name: row["company province"], region: "Việt Nam"}
    end

    City.import columns, cities, on_duplicate_key_ignore: true
  end
end
