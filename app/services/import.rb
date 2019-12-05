require "csv"

class Import
  def import
    cities = []
    companies = []
    industries = []

    city_columns = [:name, :region]
    company_columns = [:name, :email, :address, :code]
    industry_columns = [:name]

    CSV.foreach(Rails.root.join("lib", "jobss.csv"), headers: true) do |row|
      cities << {name: row["company province"], region: "Việt Nam"}
      companies << {name: row["company name"], email: row["contact email"],
        address: row["company address"], code: row["company id"]}
      industries << {name: row["category"]}
    end

    City.import city_columns, cities, on_duplicate_key_ignore: true
    puts "Cities imported"

    Company.import company_columns, companies, on_duplicate_key_ignore: true
    puts "Companies imported"

    Industry.import industry_columns, industries, on_duplicate_key_ignore: true
    puts "Industries imported"
  end
end
