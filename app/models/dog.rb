class Dog < ApplicationRecord
  has_paper_trail
  belongs_to :breed
  belongs_to :dog_state
end
