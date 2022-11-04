class CreateDogs < ActiveRecord::Migration[7.0]
  def change
    create_table :dogs do |t|
      t.references :breed, null: false, foreign_key: true
      t.string :location
      t.boolean :has_color
      t.references :dog_state, null: false, foreign_key: true
      t.string :image_file_name
      t.integer :age
      t.boolean :gender
      t.boolean :in_pound

      t.timestamps
    end
  end
end
