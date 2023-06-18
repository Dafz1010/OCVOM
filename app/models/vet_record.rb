class VetRecord < ApplicationRecord
    has_paper_trail
    has_one_attached :picture
    has_many :medical_histories
    belongs_to :age_list
    belongs_to :place
    belongs_to :created_by_user, class_name: "User"
    belongs_to :status, class_name: "PetStatusCondition", foreign_key: "pet_status_condition_id", optional: true
    belongs_to :condition, class_name: "PetStatusCondition", foreign_key: "pet_status_condition_id", optional: true
    accepts_nested_attributes_for :medical_histories, allow_destroy: true

    validate :validate_picture_content_type
    # validate :validate_status
    # validate :validate_condition
    
    def validate_status
        #validates status if ``:status_or_condition`` is True
        if status_or_condition
            validates :status, presence: true
        end
    end

    def validate_condition
        #validates condition if ``:status_or_condition`` is False
        if !status_or_condition
            validates :condition, presence: true
        end
    end

    def self.search(search)
        if search
            where("name ILIKE ? OR pet_owner ILIKE ? OR breed ILIKE ?", "%#{search}%", "%#{search}%", "%#{search}%")
        else
            all
        end
    end

    def validate_picture_content_type
        if picture.attached? && !picture.content_type.in?(%w(image/jpeg image/jpg image/png))
            errors.add(:picture, 'must be a JPEG, JPG, or PNG')
        end
    end

    def breed_name
        # binding.pry_remote
        breed.blank? ? "[Unknown Breed]" : breed
    end

    def owner
        pet_owner.blank? ? "[No Owner]" : pet_owner
    end

    def sex
        pet_gender ? "F" : "M"
    end

    def sex_long
        pet_gender ? "female" : "male"
    end

    def neutered
        pet_neutered ? "Yes" : "No"
    end

    def age_group
        age_list.group
    end

    def place_name
        place.name
    end

    def 
        

    def archive
        self.update(archived_at: Time.now)
    end

end
