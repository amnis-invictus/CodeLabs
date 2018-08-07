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
        checker_compiler_id: checker_compiler_id
        checker_url: nil,
        tests: tests,
        memory_limit: memory_limit,
        time_limit: time_limit
      }
    end
  end

  def memory_limit
    memory_limit * compiler.memory_a + compiler.memory_b
  end

  def time_limit
    time_limit * compiler.time_a + compiler.time_b
  end
end
