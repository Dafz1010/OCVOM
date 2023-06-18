class PetStatusCondition < ApplicationRecord
    has_paper_trail
    has_many :vet_records
    serialize :three_colors, Array

    enum status_or_condition: { status: true, condition: false }

    validates :name, presence: true, uniqueness: true
    validates :status_or_condition, presence: true
    validates :three_colors, presence: true, length: { is: 3 }, format: { with: /\A#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})\z/ }    

    
    
end
