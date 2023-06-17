class RecreateVetRecords < ActiveRecord::Migration[7.0]
  def change
    create_table :vet_records, id: :uuid do |t|
      t.string :name
      t.datetime :archived_at
      t.string :species

      t.timestamps
    end
  end
end
