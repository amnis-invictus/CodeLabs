class Log < ApplicationRecord
  self.inheritance_column = ''

  validates :data, presence: true

  belongs_to :submission

  enum type: { source: 0, checker: 1 }

  delegate :user, :problem_user, to: :submission, prefix: true
end
