class InvitePolicy < ApplicationPolicy
  def index?
    user.present?
  end

  def create?
    return false if user.blank?

    case resource.group_visibility.to_sym
    when :private, :moderated
      user == resource.group_owner
    when :public
      true
    end
  end
end
