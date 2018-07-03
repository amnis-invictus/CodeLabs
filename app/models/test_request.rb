class TestRequest < ApplicationRecord
  validates :solution_compiler, presence: true

  validate :solution_must_be_attached

  belongs_to :problem

  has_one_attached :solution

  enum solution_compiler: Compiler::ALL

  delegate :checker_compiler, to: :problem

  delegate :as_json, to: :decorate

  private
  def solution_must_be_attached
    errors.add :solution, :blank unless solution.attached?
  end
end
