class AllowNullOnRoleInUsers < ActiveRecord::Migration[7.0]
  def change
    change_column_null :users, :role_id, true
  end
end
