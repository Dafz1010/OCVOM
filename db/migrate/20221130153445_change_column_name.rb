class ChangeColumnName < ActiveRecord::Migration[7.0]
  def change
    rename_column :dogs, :has_color, :has_colar
    remove_column :breeds, :group
    remove_column :breeds, :origin
  end
end
