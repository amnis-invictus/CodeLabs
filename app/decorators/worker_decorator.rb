class WorkerDecorator < Draper::Decorator
  delegate_all

  def as_json *_args
    { id: id }
  end

  def status_class
    case status.to_sym
    when :disabled        then 'border-dark'
    when :ok              then 'border-success'
    when :failed          then 'border-danger'
    when :stale, :stopped then 'border-warning'
    end
  end
end
