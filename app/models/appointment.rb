class Appointment < ApplicationRecord
  belongs_to :customer
  belongs_to :dog
end
