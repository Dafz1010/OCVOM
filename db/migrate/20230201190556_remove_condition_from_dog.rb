class RemoveConditionFromDog < ActiveRecord::Migration[7.0]
  def change
    remove_reference :dogs, :condition, index: true
  end
end
