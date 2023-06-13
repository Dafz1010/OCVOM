class AddArchiveAtColumnToInventoryItems < ActiveRecord::Migration[7.0]
  def change
    add_column :inventory_items, :archived_at, :datetime
  end
end
