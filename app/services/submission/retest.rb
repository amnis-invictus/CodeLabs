class Submission::Retest
  attr_reader :submission

  delegate :pending?, to: :submission, prefix: true

  def initialize submission
    @submission = submission
  end

  def save
    submission.results.delete_all

    submission.logs.delete_all

    submission.update! test_state: :pending,  fails_count: 0, score: nil, test_result: nil, max_score: nil
  end
end
