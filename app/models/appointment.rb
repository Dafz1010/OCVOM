class Appointment < ApplicationRecord
  has_paper_trail
  belongs_to :customer
  belongs_to :dog
  belongs_to :user
end
