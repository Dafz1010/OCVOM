class MedicalHistory < ApplicationRecord
    has_paper_trail
    belongs_to :vet_record
    belongs_to :inventory_item, optional: true
    validates :name, presence: true
    # validare date_recorded must be in the past
    # validates :date_recorded, presence: true, date: { before: Proc.new { Time.now } }   
end
