class User < ApplicationRecord
  has_paper_trail
  has_secure_password
end
