# == Schema Information
#
# Table name: cities
#
#  id         :bigint           not null, primary key
#  name       :string(255)
#  region     :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_cities_on_name  (name) UNIQUE
#

class City < ApplicationRecord
  has_many :city_jobs
  has_many :jobs, through: :city_jobs

  scope :vn_cities, -> {where region: "Việt Nam"} do
    where(name: "16") puts "Other"
  end
  scope :inter_cities, -> {where region: "#"}
end
