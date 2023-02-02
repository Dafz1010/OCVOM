class CreateJoinTableDogCondition < ActiveRecord::Migration[7.0]
  def change
    create_join_table :dogs, :conditions do |t|
      t.index [:dog_id, :condition_id]
      t.index [:condition_id, :dog_id]
    end
  end
end
