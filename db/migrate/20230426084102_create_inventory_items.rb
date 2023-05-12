class CreateInventoryItems < ActiveRecord::Migration[7.0]
  def change
    create_table :inventory_items do |t|
      t.integer :quantity
      t.decimal :price
      t.date :expiration_date
      t.references :inventory, null: false, foreign_key: true
      t.timestamps
    end
  end
end
