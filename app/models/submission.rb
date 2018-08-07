class Submission < ApplicationRecord
  include AASM

  validate :source_must_be_attached

  belongs_to :problem

  belongs_to :user

  belongs_to :compiler

  has_one_attached :source

  enum test_state: { pending: 0, in_progress: 1, done: 2, failed: 3 }

  delegate :as_json, to: :decorate

  aasm column: :test_state, whiny_transitions: false, enum: true do
    state :pending, initial: true

    state :in_progress, :done, :failed

    event(:take) { transitions from: :pending, to: :in_progress }

    event(:release) { transitions from: :in_progress, to: :done }

    event :fail do
      transitions from: :in_progress, to: :pending, if: -> { fails_count < 5 }

      transitions from: :in_progress, to: :failed
    end
  end

  private
  def source_must_be_attached
    errors.add :source, :blank unless source.attached?
  end
end
