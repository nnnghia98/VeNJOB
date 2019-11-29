require 'test_helper'

class CitiesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get cities_index_url
    assert_response :success
  end

  test "should get import" do
    get cities_import_url
    assert_response :success
  end

end
