module ApplicationHelper
  def language_select_options
    I18n.available_locales.map do |locale|
      [I18n.t(:language, locale: locale), locale]
    end
  end

  def visible_compilers
    current_user.administrator? ? Compiler.all : Compiler.status_public
  end

  def checker_compilers
    current_user.administrator? ? Compiler.all : Compiler.where.not(status: :in_test)
  end

  def sanitize_for_problem text
    sanitize text, tags: %w[b br em i p span strong sub sup table tbody td th thead tr img], attributes: %w[class src alt]
  end
end
