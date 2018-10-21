class Sharing < ApplicationRecord
  validates :problem_id, uniqueness: { scope: :group_id }

  belongs_to :group

  belongs_to :problem

  delegate :owner, to: :group, prefix: true

  delegate :user, to: :problem, prefix: true
end
