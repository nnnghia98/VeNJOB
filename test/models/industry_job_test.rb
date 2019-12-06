# == Schema Information
#
# Table name: industry_jobs
#
#  id          :bigint           not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  industry_id :bigint
#  job_id      :bigint
#
# Indexes
#
#  index_industry_jobs_on_industry_id  (industry_id)
#  index_industry_jobs_on_job_id       (job_id)
#
# Foreign Keys
#
#  fk_rails_...  (industry_id => industries.id)
#  fk_rails_...  (job_id => jobs.id)
#

require 'test_helper'

class IndustryJobTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
