class AddUserToDogs < ActiveRecord::Migration[7.0]
  def change
    add_reference :dogs, :user, null: false, foreign_key: true, default: 1
    change_column_default :dogs, :user_id, nil


    # PaperTrail::Version.where(event: "Create Dog").each do |pt|
    #   dog = Dog.find(pt.item_id)
    #   user = User.find_by(username: pt.whodunnit)
    #   if dog && user
    #     dog.update(user_id: user.id)
    #   end
    # end
  end
end
