require "application_system_test_case"

class VetRecordsTest < ApplicationSystemTestCase
  setup do
    @vet_record = vet_records(:one)
  end

  test "visiting the index" do
    visit vet_records_url
    assert_selector "h1", text: "Vet records"
  end

  test "should create vet record" do
    visit vet_records_url
    click_on "New vet record"

    fill_in "Archived at", with: @vet_record.archived_at
    fill_in "Id", with: @vet_record.id
    fill_in "Name", with: @vet_record.name
    fill_in "Species", with: @vet_record.species
    click_on "Create Vet record"

    assert_text "Vet record was successfully created"
    click_on "Back"
  end

  test "should update Vet record" do
    visit vet_record_url(@vet_record)
    click_on "Edit this vet record", match: :first

    fill_in "Archived at", with: @vet_record.archived_at
    fill_in "Id", with: @vet_record.id
    fill_in "Name", with: @vet_record.name
    fill_in "Species", with: @vet_record.species
    click_on "Update Vet record"

    assert_text "Vet record was successfully updated"
    click_on "Back"
  end

  test "should destroy Vet record" do
    visit vet_record_url(@vet_record)
    click_on "Destroy this vet record", match: :first

    assert_text "Vet record was successfully destroyed"
  end
end
