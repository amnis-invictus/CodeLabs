class Result < ApplicationRecord
  validates :status, presence: true

  validates :memory, :time, presence: true, numericality: true

  enum status: {
    ok: 0,
    wrong_answer: 1,
    presentation_error: 2,
    dirt: 4,
    points: 5,
    bad_test: 6,
    unexpected_eof: 8,
    runtime_error: 10,
    memory_limit_exceded: 14,
    time_limit_exceded: 15,
    partilly_correct: 16
  }

  belongs_to :submission

  belongs_to :test

  delegate :num, to: :test, prefix: true
end
