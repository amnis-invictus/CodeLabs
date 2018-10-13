class Invite < ApplicationRecord
  validates :receiver, uniqueness: { scope: :group_id }

  validate :receiver_must_not_be_in_group

  belongs_to :group

  belongs_to :sender, class_name: 'User'

  belongs_to :receiver, class_name: 'User'

  enum status: { pending: 0, accepted: 1, rejected: 2 }

  delegate :owner, :visibility, :users, to: :group, prefix: true

  delegate :name, to: :sender, prefix: true

  delegate :name, to: :receiver, prefix: true

  private
  def receiver_must_not_be_in_group
    errors.add :receiver, :exists if group_users.include? receiver
  end
end
