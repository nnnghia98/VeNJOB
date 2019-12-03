require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @base_title = "VeNJOB"
  end

  test "should get top_page" do
    get static_pages_index_url
    assert_response :success
    assert_select "title", "Top Page | #{@base_title}"
  end
end
