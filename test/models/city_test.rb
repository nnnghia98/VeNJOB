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

require 'test_helper'

class CityTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
