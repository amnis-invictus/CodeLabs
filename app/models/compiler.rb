class Compiler < ApplicationRecord
  validates :name, :version, presence: true

  validates :memory_a, :memory_b, :time_a, :time_b, presence: true, numericality: true
end
