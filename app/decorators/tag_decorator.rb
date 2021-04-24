class TagDecorator < Draper::Decorator
  delegate_all

  def as_json *_args
    { value: id, text: name }
  end
end
