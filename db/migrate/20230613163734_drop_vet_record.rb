class DropVetRecord < ActiveRecord::Migration[7.0]
  def change
    drop_table :vet_records
  end
end
