class RemoveBooleanColumnsRenameImageFileName < ActiveRecord::Migration[7.0]
  def change
    remove_column :dogs, :has_colar
    remove_column :dogs, :in_pound
    remove_column :dogs, :two_colored_eyes
    remove_column :dogs, :archived
    remove_column :dogs, :surrender_reason
    rename_column :dogs, :image_file_name, :images
    rename_column :dog_pictures, :image_file_location, :image
  end
end
