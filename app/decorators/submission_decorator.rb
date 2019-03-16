class SubmissionDecorator < Draper::Decorator
  delegate_all

  decorates_association :problem, context: :submission

  decorates_association :user

  delegate :username, to: :user, prefix: true

  delegate :caption, to: :problem, prefix: true

  def as_json *args
    {
      id: id,
      compiler_id: compiler_id,
      problem: problem,
      source_url: source_url,
      test_state: Submission.test_states[test_state],
      fails_count: fails_count,
      memory_limit: memory_limit,
      time_limit: time_limit
    }
  end

  def source_url
    helpers.url_for source if source.attached?
  end

  def memory_limit
    problem.memory_limit * compiler.memory_a + compiler.memory_b
  end

  def time_limit
    problem.time_limit * compiler.time_a + compiler.time_b
  end

  def state
    case
    when submission.test_state_done? && submission.test_result_ok?
      "#{ submission.test_result.humanize } (#{ submission.score }/#{ submission.max_score })"
    when submission.test_state_done?
      submission.test_result.humanize
    else
      submission.test_state.humanize
    end
  end
end
