# == Schema Information
#
# Table name: user_jobs
#
#  id           :bigint           not null, primary key
#  applied_at   :datetime
#  favorited_at :datetime
#  viewed_at    :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  job_id       :bigint
#  user_id      :bigint
#
# Indexes
#
#  index_user_jobs_on_job_id   (job_id)
#  index_user_jobs_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (job_id => jobs.id)
#  fk_rails_...  (user_id => users.id)
#

require 'test_helper'

class UserJobTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
