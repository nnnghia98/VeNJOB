require 'test_helper'

class IndustriesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get industries_index_url
    assert_response :success
  end

  test "should get import" do
    get industries_import_url
    assert_response :success
  end

end
