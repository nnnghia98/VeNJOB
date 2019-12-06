# == Schema Information
#
# Table name: crawl_urls
#
#  id         :bigint           not null, primary key
#  crawled    :boolean          default(FALSE)
#  title      :string(255)
#  url        :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class CrawlUrlTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
