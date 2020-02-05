class GroupDecorator < Draper::Decorator
  delegate_all

  decorates_associations :owner, :accepted_users, :problems

  delegate :name, to: :owner, prefix: true

  delegate :state_requested?, :state_invited?, :state_accepted?, to: :current_user_membership, prefix: true, allow_nil: true

  def visibility_icon
    h.content_tag :i, '', class: visibility_icon_class, title: visibility.humanize,
      data: { toggle: :tooltip, placement: :bottom }
  end

  private

  def visibility_icon_class
    case visibility.to_sym
    when :private, :moderated
      'mr-3 fas fa-lock'
    when :public
      'mr-3 fas fa-unlock'
    end
  end

  def current_user_membership
    @current_user_membership ||= memberships.find_by user: h.current_user if h.current_user.present?
  end
end
