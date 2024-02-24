class Group < ApplicationRecord
  validates :name, :visibility, presence: true

  has_many :memberships, dependent: :destroy, class_name: 'GroupMembership', as: :membershipable

  has_many :pending_memberships, -> { where.not state: :accepted }, class_name: 'GroupMembership', as: :membershipable

  has_many :accepted_memberships, -> { where state: :accepted }, class_name: 'GroupMembership', as: :membershipable

  has_many :owner_memberships, lambda {
                                 where state: :accepted, role: :owner
                               }, class_name: 'GroupMembership', as: :membershipable

  has_many :pending_users, through: :pending_memberships, source: :user, class_name: 'User'

  has_many :accepted_users, through: :accepted_memberships, source: :user, class_name: 'User'

  has_many :owners, through: :owner_memberships, source: :user, class_name: 'User'

  has_many :submissions, through: :accepted_users

  enum visibility: { private: 0, moderated: 1, public: 2 }, _prefix: true
end
