class SubmissionDecorator < Draper::Decorator
  delegate_all

  delegate :updated_at, to: :problem, prefix: true

  def as_json *args
    {
      id: id,
      compiler: compiler,
      checker_compiler: nil,
      problem_id: problem_id,
      source_url: source_url,
      problem_updated_at: problem_updated_at,
      test_state: test_state
    }
  end

  def source_url
    h.url_for source if source.attached?
  end
end
