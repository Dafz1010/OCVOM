class CreateBreeds < ActiveRecord::Migration[7.0]
  def change
    create_table :breeds do |t|
      t.string :name
      t.string :group
      t.string :origin

      t.timestamps
    end
  end
end
