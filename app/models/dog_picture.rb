class DogPicture < ApplicationRecord
  has_paper_trail
  belongs_to :dog
  mount_uploader :image, DogImagesUploader
end
