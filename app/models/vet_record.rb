class VetRecord < ApplicationRecord
    # enum species
    has_paper_trail
    enum species: [:dog, :cat, :livestock, :other]
    
end
