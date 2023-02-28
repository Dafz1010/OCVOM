class AddUserToDogs < ActiveRecord::Migration[7.0]
  def change
    add_reference :dogs, :user, null: false, foreign_key: true, default: 1
    change_column_default :dogs, :user_id, nil


    
  end
end
