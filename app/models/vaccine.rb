class Vaccine < ApplicationRecord
    has_paper_trail
    has_and_belongs_to_many :dogs
end
    