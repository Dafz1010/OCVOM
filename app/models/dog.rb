class Dog < ApplicationRecord
  belongs_to :breed
  belongs_to :dog_state
end
