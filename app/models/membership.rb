class Membership < ApplicationRecord
  validates :state, presence: true

  validates :user, uniqueness: { scope: :group }

  validate :user_must_not_be_group_owner

  belongs_to :user

  belongs_to :group

  enum state: %i[requested invited accepted], _prefix: true

  private

  def user_must_not_be_group_owner
    return unless group.present?

    errors.add :user, :taken if user == group.owner
  end
end
