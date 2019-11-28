require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get top_page" do
    get root_path
    assert_response :success
    assert_select "title", "VeNJOB"
  end

  test "should get favorite" do
    get favorite_url
    assert_response :success
    assert_select "title", "Favorite | VeNJOB"
  end

  test "should get history" do
    get history_url
    assert_response :success
    assert_select "title", "History | VeNJOB"
  end
end
