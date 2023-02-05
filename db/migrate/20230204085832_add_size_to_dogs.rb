class AddSizeToDogs < ActiveRecord::Migration[7.0]
  def change
    add_column :dogs, :size, :boolean, default: true
  end
end
