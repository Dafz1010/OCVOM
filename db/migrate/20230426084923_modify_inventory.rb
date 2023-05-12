class ModifyInventory < ActiveRecord::Migration[7.0]
  def change
    remove_column :inventories, :quantity, :integer
    remove_column :inventories, :price, :decimal
    remove_column :inventories, :sku, :string
    rename_column :inventories, :description, :prescription
    add_column :inventories, :dosage, :string
  end
end
