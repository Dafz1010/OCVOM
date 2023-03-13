class User < ApplicationRecord
  has_paper_trail
  belongs_to :role, optional: true
  has_secure_password
  mount_uploader :profile_image, ProfileImageUploader


  validates :name, presence: true, format: { with: /\A[ A-Za-z\.]+\z/i }
  validates :username, presence: true, :uniqueness => { case_sensitive: false }, format: { with: /\A[a-z0-9_\.]+\z/i }
  validates :password, presence: true, confirmation: true, length: { minimum: 8, maximum: 30},  unless: proc { |x| x.password.blank? }
  validate  :validate_image_type
  
  def approved_user?
    approved_at?
  end

  def approved_user!
    self.update(approved_at: Time.now)
  end

  def admin?
    type == "admin"
  end

  def admin!
    self.update(role_id: Role.find_by(name: "admin").id)
  end

  def type
    role.name
  end

  def encoder?
    type == "Encoder"
  end

  def encoder!
    self.update(role_id: Role.find_by(name: "Encoder").id)
  end

  def frontliner?
    type == "Frontliner"
  end

  def frontliner!
    self.update(role_id: Role.find_by(name: "Frontliner").id)
  end

  def archive
    self.update(archived_at: Time.now)
  end

  def archived?
    archived_at?
  end

  def setrole(id)
    self.update(role_id: id)
  end

  def total_logs
    versions.where(whodunnit: username).count
  end

  def first_loggedin?
    first_login_at?
  end

  private

  def validate_image_type
    if profile_image.cached?
      if !profile_image.content_type.in?(%w(image/jpeg image/png))
        errors.add(:profile_image, 'must be a JPEG or PNG')
      end
    end
  end
end
