class UserDecorator < Draper::Decorator
  delegate_all

  def as_json *_args
    { id: id, name: name, search_suggestion: search_suggestion }
  end

  def name
    super.presence || username
  end

  def search_suggestion
    body = ''.html_safe

    body << h.content_tag(:p, name, class: 'mb-0')

    body << h.content_tag(:small, username, class: 'text-muted')

    h.content_tag :div, body
  end
end
