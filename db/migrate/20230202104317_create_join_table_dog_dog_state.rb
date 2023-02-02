class CreateJoinTableDogDogState < ActiveRecord::Migration[7.0]
  def change
    create_join_table :dogs, :dog_states do |t|
      t.index [:dog_id, :dog_state_id]
      t.index [:dog_state_id, :dog_id]
    end
  end
end
