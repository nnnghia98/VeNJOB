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

  scope :vn_cities, -> {where region: "Việt Nam"}
  scope :inter_cities, -> {where region: "#"}

  def job_count
    @job_count ||= jobs.count
  end

  def self.city_order
    @city_order ||= all.sort_by(&:job_count).reverse.take(Settings.top.city.limit)
  end
end
