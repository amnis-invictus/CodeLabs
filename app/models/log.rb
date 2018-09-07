class Log < ApplicationRecord
  self.inheritance_column = nil

  validates :data, presence: true

  enum type: { source: 0, checker: 1 }

  belongs_to :submission
end
