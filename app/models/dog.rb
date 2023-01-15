class Dog < ApplicationRecord
  has_paper_trail
  belongs_to :breed
  belongs_to :dog_state
  belongs_to :place
  has_many :dog_pictures, dependent: :destroy
  accepts_nested_attributes_for :dog_pictures, :allow_destroy => true
end
