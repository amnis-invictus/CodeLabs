class User < ApplicationRecord
  validates :email, presence: true, email: true, uniqueness: { case_sensitive: false }

  validates :username, presence: true, uniqueness: { case_sensitive: false }

  has_one_attached :avatar

  has_one :confirmation_request, dependent: :destroy

  has_many :problems, dependent: :nullify

  has_many :auth_tokens, dependent: :destroy

  has_many :submissions, dependent: :destroy

  has_many :owned_groups, class_name: 'Group', foreign_key: :owner_id, dependent: :destroy

  has_many :pending_memberships, -> { where.not state: :accepted }, class_name: 'Membership', dependent: :destroy

  has_many :accepted_memberships, -> { where state: :accepted }, class_name: 'Membership', dependent: :destroy

  has_many :pending_groups, through: :pending_memberships, source: :group, class_name: 'Group'

  has_many :accepted_groups, through: :accepted_memberships, source: :group, class_name: 'Group'

  has_many :sharings, through: :accepted_groups

  has_many :shared_problems, class_name: 'Problem', through: :sharings, source: :problem

  has_secure_password

  bitmask :roles, as: %i[confirmed moderator administrator], null: false

  after_create_commit :send_email

  delegate :as_json, to: :decorate

  values_for_roles.each do |value|
    define_method("#{ value }?") { roles? value }
  end

  private

  def send_email
    UserMailer.email(self).deliver_later
  end
end
