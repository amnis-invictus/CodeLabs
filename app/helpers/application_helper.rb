module ApplicationHelper
  ALLOWED_TAGS = %w[b br em i u p span strong sub sup table tbody td th thead tr img ul ol li].freeze

  ALLOWED_ATTRIBUTES = %w[class src alt].freeze

  def language_select_options
    I18n.available_locales.map { |locale| [translate(:language, locale:), locale] }
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

  def contest_visibility_select_options
    Contest.visibilities.keys.map { [_1, data: { subtext: translate(_1, scope: 'contest.shared.visibility') }] }
  end

  def group_visibility_select_options
    Group.visibilities.keys.map { [_1, data: { subtext: translate(_1, scope: 'group.shared.visibility') }] }
  end

  def filter_toggle param, label: t(".#{ param }"), disabled: false
    render partial: 'widgets/filter/toggle', locals: { param:, label:, disabled: }
  end

  def filter_dropdown form, param, url: "/#{ param.to_s.pluralize }.json?query=%", header: t(".#{ param }_filter"),
                      id_method: :id, query_method: :name
    hidden_field = "#{ param }_#{ id_method }"

    query_field = "#{ param }_#{ query_method }"

    render partial: 'widgets/filter/dropdown', locals: { form:, param:, url:, header:, hidden_field:, query_field: }
  end
end
