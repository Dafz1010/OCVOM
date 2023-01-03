class DogPicture < ApplicationRecord
  has_paper_trail
  belongs_to :dog
  mount_uploader :profile_image, ProfileImageUploader
end
