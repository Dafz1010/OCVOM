class AddAgeReferenceToVetRecords < ActiveRecord::Migration[7.0]
  def change
    add_reference :vet_records, :age, null: false, foreign_key: { to_table: :age_lists }
  end
end
