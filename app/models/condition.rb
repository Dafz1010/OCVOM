class Condition < ApplicationRecord
    has_and_belongs_to_many :dogs
    has_paper_trail
end
