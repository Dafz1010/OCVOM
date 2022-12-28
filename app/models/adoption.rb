class Adoption < ApplicationRecord
  has_paper_trail
  belongs_to :customer
  belongs_to :dog
end
