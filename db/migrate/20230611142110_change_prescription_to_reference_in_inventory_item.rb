class ChangePrescriptionToReferenceInInventoryItem < ActiveRecord::Migration[7.0]
  def change
    remove_column :inventories, :prescription
    add_reference :inventory_items, :age_list, foreign_key: true
  end
end
