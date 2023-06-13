class InventoryItem < ApplicationRecord
    has_paper_trail
    belongs_to :inventory
    belongs_to :age_list

    validates :quantity, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
    validates :price, presence: true, numericality: { greater_than_or_equal_to: 1 }
    # validates :expiration_date, presence: true, date: { after: Proc.new { Time.now } }

    def expired?
        self.expiration_date < Time.now
    end

    def days_left
        (self.expiration_date.to_date - Time.now.to_date).to_i
    end

    def adult?
        self.age_list.group == "Adult"
    end

    def young?
        self.age_list.group == "Young"
    end

    def archive
        self.update(archived_at: Time.now)
    end
end
