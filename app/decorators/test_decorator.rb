class TestDecorator < Draper::Decorator
  delegate_all

  def as_json *args
    {
      id: id,
      num: num,
      input_url: input_url,
      answer_url: answer_url
    }
  end

  def input_url
    h.url_for input if input.attached?
  end

  def answer_url
    h.url_for answer if answer.attached?
  end
end
