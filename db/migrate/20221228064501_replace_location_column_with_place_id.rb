class ReplaceLocationColumnWithPlaceId < ActiveRecord::Migration[7.0]
  def change
    add_reference :dogs, :place, null: false, foreign_key: true
    remove_column :dogs, :location
  end
end
