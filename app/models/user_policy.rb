class UserPolicy < ApplicationRecord
    has_paper_trail
    belongs_to :user
end
