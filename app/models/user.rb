class User < ApplicationRecord
  validates :email, presence: true, email: true, uniqueness: { case_sensitive: false }

  has_many :auth_tokens, dependent: :destroy

  has_one_attached :avatar

  has_secure_password
end
