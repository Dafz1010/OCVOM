class CreateVetRecords < ActiveRecord::Migration[7.0]
  def change
    create_table :vet_records do |t|
      t.string :name
      t.string :location
      t.datetime :archived_at
      t.uuid :uuid, default: 'uuid_generate_v4()'
      t.string :species
      t.integer :age
      t.timestamps
    end
  end
end
