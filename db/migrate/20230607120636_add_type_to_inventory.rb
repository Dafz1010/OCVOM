class AddTypeToInventory < ActiveRecord::Migration[7.0]
  def change
    add_column :inventories, :type, :string
  end
end
