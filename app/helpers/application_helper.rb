module ApplicationHelper
  def language_select_options
    I18n.available_locales.map do |locale|
      [I18n.t(:language, locale: locale), locale]
    end
  end
end
