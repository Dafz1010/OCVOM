class RenameAgeReferenceToAgeListFromVetRecords < ActiveRecord::Migration[7.0]
  def change
    rename_column :vet_records, :age_id, :age_list_id
    # age_list null false and foreign key to true
    change_column_null :vet_records, :age_list_id, false
    add_foreign_key :vet_records, :age_lists, column: :age_list_id, primary_key: :id
  end
end
