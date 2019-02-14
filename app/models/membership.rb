class Membership < ApplicationRecord
  validates :state, presence: true

  validates :user, uniqueness: { scope: :group }

  belongs_to :user

  belongs_to :group

  enum state: %i[requested invited accepted], _prefix: true
end
