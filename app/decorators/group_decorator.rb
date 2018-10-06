class GroupDecorator < Draper::Decorator
  delegate_all

  def visibility_icon
    h.content_tag :i, '', class: visibility_icon_class, title: visibility, data: { toggle: :tooltip, placement: :bottom }
  end

  private
  def visibility_icon_class
    case visibility.to_sym
    when :private, :moderated
      'fas fa-lock'
    when :public
      'fas fa-unlock'
    end
  end
end
