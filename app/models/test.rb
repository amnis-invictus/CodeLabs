class Test < ApplicationRecord
  validates :num, presence: true

  belongs_to :problem

  has_one_attached :input

  has_one_attached :answer
end
