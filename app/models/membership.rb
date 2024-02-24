class Membership < ApplicationRecord
  validates :state, presence: true

  validates :user, uniqueness: { scope: %i[membershipable_id membershipable_type] }

  belongs_to :user

  belongs_to :membershipable, polymorphic: true

  enum state: { requested: 0, invited: 1, accepted: 2 }, _prefix: true

  enum role: { user: 0, owner: 1 }, _prefix: true
end
