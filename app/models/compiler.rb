class Compiler < ApplicationRecord
  validates :name, :version, presence: true

  validates :memory_a, :memory_b, :time_a, :time_b, presence: true, numericality: true

  validates :visible, inclusion: { in: [true, false] }
end
