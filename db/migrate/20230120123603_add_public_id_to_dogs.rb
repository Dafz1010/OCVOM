class AddPublicIdToDogs < ActiveRecord::Migration[7.0]
  def change
    add_column :dogs, :public_id, :string
  end
end
