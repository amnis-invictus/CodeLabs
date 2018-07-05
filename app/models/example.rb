class Example < ApplicationRecord
  validates :input, :answer, presence: true
  
  belongs_to :problem
end
