class Log < ApplicationRecord
  self.inheritance_column = ''

  validates :data, presence: true

  enum type: { source: 0, checker: 1 }

  belongs_to :submission
end
