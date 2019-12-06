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

require 'test_helper'

class IndustryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
