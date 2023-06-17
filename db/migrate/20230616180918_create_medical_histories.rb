class CreateMedicalHistories < ActiveRecord::Migration[7.0]
  def change
    create_table :medical_histories do |t|
      t.string :name
      t.text :description
      t.string :vet_place
      t.datetime :date_recorded
      # references to vet_record uuid
      t.references :vet_record, null: false, foreign_key: true, type: :uuid
      t.references :inventory_item, null: true, foreign_key: true

      t.timestamps
    end
  end
end
