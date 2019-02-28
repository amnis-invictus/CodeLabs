class GroupDecorator < Draper::Decorator
  delegate_all

  decorates_associations :owner, :accepted_users, :problems

  delegate :name, to: :owner, prefix: true

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
end
