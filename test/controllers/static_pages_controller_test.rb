require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @base_title = "VeNJOB"
  end
  
  test "should get top_page" do
    get static_pages_top_page_url
    assert_response :success
    assert_select "title", "Top Page | #{@base_title}"
  end

  test "should get favorite" do
    get static_pages_favorite_url
    assert_response :success
    assert_select "title", "Favorite | #{@base_title}"
  end

  test "should get history" do
    get static_pages_history_url
    assert_response :success
    assert_select "title", "History | #{@base_title}"
  end
end
