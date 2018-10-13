class Invite < ApplicationRecord
  validates :receiver, uniqueness: { scope: :group_id }

  belongs_to :group

  belongs_to :sender, class_name: 'User'

  belongs_to :receiver, class_name: 'User'

  enum status: { pending: 0, accepted: 1, rejected: 2 }

  delegate :owner, :visibility, to: :group, prefix: true

  delegate :name, to: :sender, prefix: true

  delegate :name, to: :receiver, prefix: true
end
