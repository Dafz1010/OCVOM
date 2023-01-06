class CreateDogStates < ActiveRecord::Migration[7.0]
  def change
    create_table :dog_states do |t|
      t.string :name

      t.timestamps
    end
  end
end
