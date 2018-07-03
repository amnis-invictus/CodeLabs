class TestRequest < ApplicationRecord
  validates :testing_type, :solution_compiler, presence: true

  belongs_to :problem

  has_one_attached :solution

  enum solution_compiler: Compiler::ALL

  delegate :checker_compiler, :testing_type, to: :problem
end
