class DogPicture < ApplicationRecord
  has_paper_trail
  belongs_to :dog
end
