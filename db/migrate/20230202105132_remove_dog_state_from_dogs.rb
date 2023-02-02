class RemoveDogStateFromDogs < ActiveRecord::Migration[7.0]
  def change
    remove_reference :dogs, :dog_state, index: true
  end
end
