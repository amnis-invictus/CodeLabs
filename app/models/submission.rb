class Submission < ApplicationRecord
  include AASM

  validate :source_must_be_attached

  belongs_to :problem

  belongs_to :user

  belongs_to :compiler

  has_one_attached :source

  has_many :results, dependent: :destroy

  has_many :logs, dependent: :destroy

  enum test_state: { pending: 0, in_progress: 1, done: 2, failed: 3 }, _prefix: true

  enum test_result: { ok: 0, compiler_error: 1 }, _prefix: true

  delegate :as_json, to: :decorate

  delegate :user, :private?, to: :problem, prefix: true

  after_commit :update_standings

  aasm column: :test_state, whiny_transitions: false, enum: true do
    state :pending, initial: true

    state :in_progress, :done, :failed

    event(:take) { transitions from: :pending, to: :in_progress }

    event(:release) { transitions from: :in_progress, to: :done }

    event :fail, after: -> { increment! :fails_count } do
      transitions from: :in_progress, to: :pending, if: -> { fails_count < 5 }, after: -> { results.delete_all }

      transitions from: :in_progress, to: :failed
    end
  end

  private

  def source_must_be_attached
    errors.add :source, :blank unless source.attached?
  end

  def update_standings
    StandingRedisStore.update_if_exists user_id, problem_id, score
  end
end
