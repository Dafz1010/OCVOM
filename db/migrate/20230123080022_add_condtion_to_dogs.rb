class AddCondtionToDogs < ActiveRecord::Migration[7.0]
  def change
    add_reference :dogs, :condition, foreign_key: true
  end
end
