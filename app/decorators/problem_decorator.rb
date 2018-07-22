class ProblemDecorator < Draper::Decorator
  delegate_all

  decorates_association :tests

  def as_json *args
    {
      id: id,
      updated_at: updated_at,
      checker_compiler: nil,
      checker_url: nil,
      tests: tests
    }
  end
end
