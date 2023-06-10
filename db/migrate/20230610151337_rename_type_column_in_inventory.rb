class RenameTypeColumnInInventory < ActiveRecord::Migration[7.0]
  def change
    rename_column :inventories, :type, :inventory_type
    remove_column :inventory_items, :dosage, :string
  end
end
