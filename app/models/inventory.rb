class Inventory < ApplicationRecord
    has_paper_trail
    has_many :inventory_items, dependent: :destroy

    validates :name, presence: true, uniqueness: true
    validates :category, presence: true, uniqueness: true

    PRESCRIPTION_SELECTION = [
        "0 to 2 months",
        "3 to 4 months",
        "5 to 6 months",
        "7 to 8 months",
        "9 to 10 months",
        "11 to 12 months",
        "1 to 3 years",
        "4 to 6 years",
        "7 to 10 years",
        "11 to 15 years",
        "16 to 20 years",
        "20 years and above"
    ]


    def total_quantity
        self.inventory_items.sum(:quantity)
    end

    # get last price of inventory item
    def last_price
        self.inventory_items.last.price
    end

    def items
        self.inventory_items
    end

end
