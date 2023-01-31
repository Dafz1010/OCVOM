require "test_helper"

class DataExportControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get data_export_index_url
    assert_response :success
  end
end
