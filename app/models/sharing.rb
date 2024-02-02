class Sharing < ApplicationRecord
  validates :problem_id, uniqueness: { scope: :contest_id }

  belongs_to :contest

  belongs_to :problem

  delegate :owner, to: :contest, prefix: true

  delegate :user, to: :problem, prefix: true
end
