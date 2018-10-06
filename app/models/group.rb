class Group < ApplicationRecord
  validates :name, :visibility, presence: true

  belongs_to :owner, class_name: 'User'

  has_many :invites

  has_and_belongs_to_many :users

  enum visibility: { private: 0, moderated: 1, public: 2 }, _prefix: true
end
