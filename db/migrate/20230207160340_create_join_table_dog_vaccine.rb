class CreateJoinTableDogVaccine < ActiveRecord::Migration[7.0]
  def change
    create_join_table :dogs, :vaccines do |t|
      t.index [:dog_id, :vaccine_id]
      t.index [:vaccine_id, :dog_id]
    end
  end
end
