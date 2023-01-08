class User < ApplicationRecord
  has_paper_trail
  belongs_to :role, optional: true
  has_secure_password
  mount_uploader :profile_image, ProfileImageUploader
  attr_accessor :skip_password_validation


  validates :name, presence: true, format: { with: /\A[ A-Za-z\.]+\z/i }
  validates :username, presence: true, :uniqueness => { case_sensitive: false }, format: { with: /\A[a-z0-9_\.]+\z/i }
  validates :password, presence: true, confirmation: true, length: { minimum: 8, maximum: 30}, unless: :skip_password_validation
  validates :role_id, presence: true, allow_blank: true
  validate  :validate_image_type
  
  private

  def validate_image_type
    if profile_image.cached?
      if !profile_image.content_type.in?(%w(image/jpeg image/png))
        errors.add(:profile_image, 'must be a JPEG or PNG')
      end
    end
  end
end
