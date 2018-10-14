class User < ApplicationRecord
  validates :email, presence: true, email: true, uniqueness: { case_sensitive: false }

  validates :username, presence: true, uniqueness: { case_sensitive: false }

  has_many :auth_tokens, dependent: :destroy

  has_many :submissions, dependent: :destroy

  has_many :owned_groups, class_name: 'Group', foreign_key: :owner_id

  has_many :sent_invites, class_name: 'Invite', foreign_key: :sender_id

  has_many :received_invites, class_name: 'Invite', foreign_key: :receiver_id

  has_and_belongs_to_many :groups

  has_one_attached :avatar

  has_secure_password

  delegate :as_json, to: :decorate
end
