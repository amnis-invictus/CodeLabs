class Membership < ApplicationRecord
  validates :state, presence: true

  validates :user, uniqueness: { scope: :contest }

  validate :user_must_not_be_contest_owner

  belongs_to :user

  belongs_to :contest

  enum state: { requested: 0, invited: 1, accepted: 2 }, _prefix: true

  private

  def user_must_not_be_contest_owner
    return if contest.blank?

    errors.add :user, :taken if user == contest.owner
  end
end
