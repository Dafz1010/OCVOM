class AgeList < ApplicationRecord
    has_paper_trail
    belongs_to :inventory_item
    # has_many :inventory_items, dependent: :destroy
end
