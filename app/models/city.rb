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
  scope :vn_cities, -> {where region: "Việt Nam"}
  scope :inter_cities, -> {where region: "#"}
  has_many :city_jobs
end
