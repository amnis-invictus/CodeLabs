class User < ApplicationRecord
  validates :email, presence: true, email: true, uniqueness: { case_sensitive: false }

  validates :username, presence: true, uniqueness: { case_sensitive: false }

  has_one :confirmation_request, dependent: :destroy

  has_many :problems, dependent: :nullify

  has_many :auth_tokens, dependent: :destroy

  has_many :submissions, dependent: :destroy

  has_many :owned_groups, class_name: 'Group', foreign_key: :owner_id, dependent: :destroy

  has_many :sent_invites, class_name: 'Invite', foreign_key: :sender_id, dependent: :destroy

  has_many :received_invites, class_name: 'Invite', foreign_key: :receiver_id, dependent: :destroy

  has_and_belongs_to_many :groups

  has_one_attached :avatar

  has_secure_password

  bitmask :roles, as: %i(confirmed moderator administrator), null: false

  delegate :as_json, to: :decorate

  values_for_roles.each do |value|
    define_method("#{ value }?") { roles? value }
  end
end
