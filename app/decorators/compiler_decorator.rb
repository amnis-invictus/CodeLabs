class CompilerDecorator < Draper::Decorator
  delegate_all

  def as_json *_args
    {
      id: id,
      name: name,
      version: version,
      memory_a: memory_a,
      memory_b: memory_b,
      time_a: time_a,
      time_b: time_b,
    }
  end
end
