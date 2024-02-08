class User < ApplicationRecord
  CONTEST_OPEN_CONDITION = <<-SQL.squish.freeze
    (contests.starts_at IS NULL OR contests.starts_at <= NOW()) AND (contests.ends_at IS NULL OR contests.ends_at >= NOW())
  SQL

  validates :email, presence: true, email: true, uniqueness: { case_sensitive: false }

  validates :username, presence: true, uniqueness: { case_sensitive: false }

  has_one_attached :avatar

  has_one :confirmation_request, dependent: :destroy

  has_many :problems, dependent: :nullify

  has_many :auth_tokens, dependent: :destroy

  has_many :submissions, dependent: :destroy

  has_many :owned_contests, class_name: 'Contest', foreign_key: :owner_id, dependent: :destroy

  has_many :pending_memberships, -> { where.not state: :accepted }, class_name: 'Membership', dependent: :destroy

  has_many :accepted_memberships, -> { where state: :accepted }, class_name: 'Membership', dependent: :destroy

  has_many :pending_contests, through: :pending_memberships, source: :membershipable, source_type: 'Contest'

  has_many :accepted_contests, through: :accepted_memberships, source: :membershipable, source_type: 'Contest'

  has_many :sharings, through: :accepted_contests

  has_many :shared_problems, -> { where CONTEST_OPEN_CONDITION }, class_name: 'Problem', through: :sharings, source: :problem

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
