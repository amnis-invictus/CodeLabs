class Submission < ApplicationRecord
  validates :compiler, presence: true

  validate :source_must_be_attached

  belongs_to :problem

  belongs_to :user

  has_one_attached :source

  enum compiler: Compiler::ALL, test_state: { pending: 0, in_progress: 1, done: 2 }

  delegate :as_json, to: :decorate

  private
  def source_must_be_attached
    errors.add :source, :blank unless source.attached?
  end
end
