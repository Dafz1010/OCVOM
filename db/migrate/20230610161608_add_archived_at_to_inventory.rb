class AddArchivedAtToInventory < ActiveRecord::Migration[7.0]
  def change
    add_column :inventories, :archived_at, :datetime
  end
end
