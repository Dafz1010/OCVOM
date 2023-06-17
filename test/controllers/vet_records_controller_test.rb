require "test_helper"

class VetRecordsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @vet_record = vet_records(:one)
  end

  test "should get index" do
    get vet_records_url
    assert_response :success
  end

  test "should get new" do
    get new_vet_record_url
    assert_response :success
  end

  test "should create vet_record" do
    assert_difference("VetRecord.count") do
      post vet_records_url, params: { vet_record: { archived_at: @vet_record.archived_at, id: @vet_record.id, name: @vet_record.name, species: @vet_record.species } }
    end

    assert_redirected_to vet_record_url(VetRecord.last)
  end

  test "should show vet_record" do
    get vet_record_url(@vet_record)
    assert_response :success
  end

  test "should get edit" do
    get edit_vet_record_url(@vet_record)
    assert_response :success
  end

  test "should update vet_record" do
    patch vet_record_url(@vet_record), params: { vet_record: { archived_at: @vet_record.archived_at, id: @vet_record.id, name: @vet_record.name, species: @vet_record.species } }
    assert_redirected_to vet_record_url(@vet_record)
  end

  test "should destroy vet_record" do
    assert_difference("VetRecord.count", -1) do
      delete vet_record_url(@vet_record)
    end

    assert_redirected_to vet_records_url
  end
end
