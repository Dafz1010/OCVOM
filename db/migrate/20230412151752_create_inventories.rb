class CreateInventories < ActiveRecord::Migration[7.0]
  def change
    create_table :inventories do |t|
      t.string :name
      t.integer :quantity
      t.decimal :price
      t.text :description
      t.string :sku
      t.string :category
      t.string :manufacturer

      t.timestamps
    end
  end
end
