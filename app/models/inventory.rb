class Inventory < ApplicationRecord
    has_paper_trail
    has_many :inventory_items, dependent: :destroy

    validates :name, presence: true, uniqueness: true
    validates :category, presence: true, uniqueness: true

    def total_quantity
        self.inventory_items.sum(:quantity)
    end

    # get last price of inventory item
    def last_price
        self.inventory_items.last.price
    end

end
