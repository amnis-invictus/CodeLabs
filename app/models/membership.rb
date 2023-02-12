class Membership < ApplicationRecord
  validates :state, presence: true

  validates :user, uniqueness: { scope: :group }

  validate :user_must_not_be_group_owner

  belongs_to :user

  belongs_to :group

  enum state: { requested: 0, invited: 1, accepted: 2 }, _prefix: true

  private

  def user_must_not_be_group_owner
    return if group.blank?

    errors.add :user, :taken if user == group.owner
  end
end
