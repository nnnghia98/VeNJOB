# == Schema Information
#
# Table name: city_jobs
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  city_id    :bigint
#  job_id     :bigint
#
# Indexes
#
#  index_city_jobs_on_city_id  (city_id)
#  index_city_jobs_on_job_id   (job_id)
#
# Foreign Keys
#
#  fk_rails_...  (city_id => cities.id)
#  fk_rails_...  (job_id => jobs.id)
#

class CityJob < ApplicationRecord
  belongs_to :city
  belongs_to :job

  def city_id
    self.city.id
  end

  def job_id
    self.job.id
  end
end
