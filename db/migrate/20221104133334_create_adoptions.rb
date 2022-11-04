class CreateAdoptions < ActiveRecord::Migration[7.0]
  def change
    create_table :adoptions do |t|
      t.references :customer, null: false, foreign_key: true
      t.references :dog, null: false, foreign_key: true
      t.date :date_adopted

      t.timestamps
    end
  end
end
