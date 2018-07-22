class Submission < ApplicationRecord
  include AASM

  validates :compiler, presence: true

  validate :source_must_be_attached

  belongs_to :problem

  belongs_to :user

  has_one_attached :source

  enum compiler: Compiler::ALL, test_state: { pending: 0, in_progress: 1, done: 2 }

  delegate :as_json, to: :decorate

  aasm column: :test_state, whiny_transitions: false do
    state :pending, initial: true

    state :in_progress, :done

    event(:take) { transitions from: :pending, to: :in_progress }

    event(:release) { transitions from: :in_progress, to: :done }
  end

  private
  def source_must_be_attached
    errors.add :source, :blank unless source.attached?
  end
end
