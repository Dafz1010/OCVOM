class CreatePetStatusConditions < ActiveRecord::Migration[7.0]
  def change
    create_table :pet_status_conditions do |t|
      t.string :name
      # statur or condition
      t.boolean :status_or_condition
      # array of 3 colors
      t.string :three_colors
      t.timestamps
    end
  end
end
