class Inventory < ApplicationRecord
    has_paper_trail
    has_many :inventory_items, dependent: :destroy
    

    validates :name, presence: true, uniqueness: true

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
        self.unarchived_items.sum(:quantity)
    end

    # get last price of inventory item
    def last_price
        self.inventory_items.last.price
    end

    def items
        self.unarchived_items
    end

    def unarchived_items
        self.inventory_items.where(archived_at: nil)
    end

    def archive
        self.update(archived_at: Time.now)
    end

    def expired_items
        self.unarchived_items.select { |item| item.expired? }
    end

    def unexpired_items
        self.unarchived_items.select { |item| !item.expired? }
    end

    def prescription
        case
        when self.unarchived_items.empty?
          "No items"
        when self.unexpired_items.any? { |item| item.young? } && self.unexpired_items.any? { |item| item.adult? }
          "Young/Adult"
        when self.unexpired_items.any? { |item| item.adult? }
          "Adult"
        when self.unexpired_items.any? { |item| item.young? }
          "Young"
        end
    end

    def price_range
        return "No items" if self.unarchived_items.empty?
  
        price_min = self.unarchived_items.minimum(:price)
        price_max = self.unarchived_items.maximum(:price)
        
        price_min == price_max ? "₱#{price_min}" : "₱#{price_min} to ₱#{price_max}"
    end

end
