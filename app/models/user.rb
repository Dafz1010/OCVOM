class User < ApplicationRecord
  has_paper_trail
  belongs_to :role, optional: true
  has_secure_password

  validates :name, presence: true
  validates :username, presence: true, :uniqueness => { case_sensitive: false }
  validates :password, presence: true, confirmation: true
  validates :role_id, presence: true, allow_blank: true
end
