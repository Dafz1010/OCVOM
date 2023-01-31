class DogState < ApplicationRecord
    has_many :dogs
    has_paper_trail
end
