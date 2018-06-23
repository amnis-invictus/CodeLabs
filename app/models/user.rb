class User < ApplicationRecord
  validates :email, presence: true, email: true

  has_many :auth_tokens, dependent: :destroy

  has_secure_password
end
