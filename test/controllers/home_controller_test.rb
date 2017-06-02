require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "should get main" do
    get home_main_url
    assert_response :success
  end

end
