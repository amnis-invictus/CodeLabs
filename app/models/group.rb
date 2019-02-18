class Group < ApplicationRecord
  validates :name, :visibility, presence: true

  belongs_to :owner, class_name: 'User'

  has_many :sharings, dependent: :destroy

  has_many :pending_memberships, -> { where.not state: :accepted }, class_name: 'Membership', dependent: :destroy

  has_many :accepted_memberships, -> { where state: :accepted }, class_name: 'Membership', dependent: :destroy

  has_many :problems, -> { order :id }, through: :sharings

  has_many :pending_users, through: :pending_memberships, source: :user, class_name: 'User'

  has_many :accepted_users, through: :accepted_memberships, source: :user, class_name: 'User'

  has_many :submissions, through: :accepted_users

  enum visibility: { private: 0, moderated: 1, public: 2 }, _prefix: true
end
