class SubmissionDecorator < Draper::Decorator
  delegate_all

  decorates_association :problem, context: :submission

  def as_json *args
    {
      id: id,
      compiler_id: compiler_id,
      problem: problem
      source_url: source_url,
      test_state: test_state,
      fails_count: fails_count
    }
  end

  def source_url
    h.url_for source if source.attached?
  end
end
