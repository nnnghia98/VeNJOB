# In db
# t.string :name
# t.string :email, unique: true
# t.text :description
# t.string :address

# add_index :industries, :name, unique: true

require "csv"
require "activerecord-import"
# require "activerecord -import/active_record/adapters/mysql_adapter"

class Company < ApplicationRecord
  has_many :jobs, dependent: :destroy

  def self.companies_import
    companies = []
    columns = [:name, :email, :address, :company_code]

    CSV.foreach(Rails.root.join("lib", "jobss.csv"), headers: true) do |row|
      companies << {name: row["company name"], email: row["contact email"], address: row["company address"], company_code: row["company id"]}
    end

    Company.import columns, companies, on_duplicate_key_ignore: true
  end
end
