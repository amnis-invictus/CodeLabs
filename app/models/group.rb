class Group < ApplicationRecord
  validates :name, :visibility, presence: true

  belongs_to :owner, class_name: 'User'

  has_many :sharings, dependent: :destroy

  has_many :memberships, dependent: :destroy

  has_many :problems, -> { order :id }, through: :sharings

  has_many :users, through: :memberships

  has_many :submissions, through: :users

  enum visibility: { private: 0, moderated: 1, public: 2 }, _prefix: true
end
