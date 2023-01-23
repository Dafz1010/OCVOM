class Dog < ApplicationRecord
  has_paper_trail
  belongs_to :breed
  belongs_to :dog_state
  belongs_to :place
  belongs_to :condition

  has_many :dog_pictures, dependent: :destroy
  accepts_nested_attributes_for :dog_pictures, :allow_destroy => true

  def breed_name
    breed.name
  end

  def status
    dog_state.name
  end

  def location
    place.name
  end

  def sex
    gender ? "Male" : "Female"
  end


end
