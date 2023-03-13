require "test_helper"

class FirstLoginControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get first_login_index_url
    assert_response :success
  end
end
