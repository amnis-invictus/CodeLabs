module ApplicationHelper
  ALLOWED_TAGS = %w[b br em i u p span strong sub sup table tbody td th thead tr img ul ol li].freeze

  ALLOWED_ATTRIBUTES = %w[class src alt].freeze

  def language_select_options
    I18n.available_locales.map { |locale| [translate(:language, locale: locale), locale] }
  end

  def visible_compilers
    current_user.administrator? ? Compiler.all : Compiler.status_public
  end

  def checker_compilers
    current_user.administrator? ? Compiler.all : Compiler.where.not(status: :in_test)
  end

  def sanitize_for_problem text
    sanitize text, tags: ALLOWED_TAGS, attributes: ALLOWED_ATTRIBUTES
  end
end
