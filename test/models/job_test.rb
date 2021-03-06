# == Schema Information
#
# Table name: jobs
#
#  id              :bigint           not null, primary key
#  category        :integer
#  code            :string(255)
#  description     :text(65535)
#  expiration_date :datetime
#  level           :string(255)
#  other_salary    :string(255)
#  post_date       :datetime
#  requirement     :text(65535)
#  salary          :string(255)
#  short_des       :text(65535)
#  title           :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  company_id      :bigint
#
# Indexes
#
#  index_jobs_on_code        (code) UNIQUE
#  index_jobs_on_company_id  (company_id)
#
# Foreign Keys
#
#  fk_rails_...  (company_id => companies.id)
#

require 'test_helper'

class JobTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
