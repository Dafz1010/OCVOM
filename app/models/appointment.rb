class Appointment < ApplicationRecord
  belongs_to :customer
  belongs_to :dog
  belongs_to :user
end
