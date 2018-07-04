class SubmissionDecorator < Draper::Decorator
  delegate_all

  def as_json *args
    {
      id: id,
      compiler: compiler,
      problem_id: problem_id,
      source_url: source_url
    }
  end

  def source_url
    h.url_for source if source.attached?
  end
end
