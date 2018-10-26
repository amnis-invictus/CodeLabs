module ApplicationHelper
  def language_select_options
    I18n.available_locales.map do |locale|
      [I18n.t(:language, locale: locale), locale]
    end
  end

  def sanitize_for_problem text
    sanitize text, tags: %w(b br em i p span strong sub sup table tbody td th thead tr), attributes: %w(class)
  end
end
