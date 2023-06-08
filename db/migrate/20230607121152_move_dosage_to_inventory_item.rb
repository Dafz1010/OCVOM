class MoveDosageToInventoryItem < ActiveRecord::Migration[7.0]
  def change
    add_column :inventory_items, :dosage, :string
    remove_column :inventories, :dosage, :string
  end
end
