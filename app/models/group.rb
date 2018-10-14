class Group < ApplicationRecord
  validates :name, :visibility, presence: true

  belongs_to :owner, class_name: 'User'

  has_many :invites

  has_and_belongs_to_many :users

  has_many :submissions, through: :users

  enum visibility: { private: 0, moderated: 1, public: 2 }, _prefix: true

  delegate :name, to: :owner, prefix: true
end
