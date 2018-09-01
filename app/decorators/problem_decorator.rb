class ProblemDecorator < Draper::Decorator
  delegate_all

  decorates_association :tests

  def as_json *args
    case context
    when :submission
      {
        id: id,
        updated_at: updated_at,
        checker_compiler_id: checker_compiler_id
      }
    else
      {
        id: id,
        updated_at: updated_at,
        checker_compiler_id: checker_compiler_id,
        checker_source_url: checker_source_url,
        tests: tests
      }
    end
  end

  def checker_source_url
    h.url_for checker_source if checker_source.attached?
  end
end