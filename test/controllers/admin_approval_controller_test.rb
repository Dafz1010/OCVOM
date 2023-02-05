require "test_helper"

class AdminApprovalControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_approval_index_url
    assert_response :success
  end
end
