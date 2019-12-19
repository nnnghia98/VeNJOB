# == Schema Information
#
# Table name: industries
#
#  id         :bigint           not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_industries_on_name  (name) UNIQUE
#

class Industry < ApplicationRecord
  has_many :industry_jobs
  has_many :jobs, through: :industry_jobs

  def job_count
    @job_count ||= jobs.count
  end

  def self.industry_order
    @industry_order ||= all.sort_by(&:job_count).reverse.take(Settings.top.city.limit)
  end
end
