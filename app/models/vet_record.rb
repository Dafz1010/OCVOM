class VetRecord < ApplicationRecord
    has_paper_trail
    has_one_attached :picture
    belongs_to :age_list
    has_many :medical_histories
    accepts_nested_attributes_for :medical_histories, allow_destroy: true

    validate :validate_picture_content_type

    def validate_picture_content_type
        if picture.attached? && !picture.content_type.in?(%w(image/jpeg image/jpg image/png))
            errors.add(:picture, 'must be a JPEG, JPG, or PNG')
        end
    end
end
