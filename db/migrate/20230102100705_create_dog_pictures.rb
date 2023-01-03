class CreateDogPictures < ActiveRecord::Migration[7.0]
  def change
    create_table :dog_pictures do |t|
      t.references :dog, null: false, foreign_key: true
      t.string :image_file_location
      t.datetime :archived_at, null: true

      t.timestamps
    end
  end
end
