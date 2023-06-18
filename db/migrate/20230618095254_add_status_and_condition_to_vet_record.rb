class AddStatusAndConditionToVetRecord < ActiveRecord::Migration[7.0]
  def change
    add_reference :vet_records, :status, null: true, foreign_key: { to_table: :pet_status_conditions}
    add_reference :vet_records, :condition, null: true, foreign_key: { to_table: :pet_status_conditions}
  end
end
