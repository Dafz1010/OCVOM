class RenameImageFileLocationToImagesOnDogPictures < ActiveRecord::Migration[7.0]
  def change
    rename_column :dog_pictures, :image_file_location, :image unless DogPicture.column_names.include?('image')
  end
end
