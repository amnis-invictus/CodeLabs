class MembershipPolicy < ApplicationPolicy
  def create?
    return false if user.blank?

    return true if resource.group.blank? || resource.user.blank? || resource.state.blank? # should be validation errors

    case resource.state
    when 'invited'
      return true if user == resource.group.owner

      resource.group.visibility_public? && resource.group.users.include?(user)
    when 'requested'
      resource.group.visibility_moderated? && user == resource.user
    when 'accepted'
      resource.group.visibility_public? && user == resource.user
    end
  end

  def destroy?
    return false if user.blank?

    user == resource.user || user == resource.group.owner
  end
end
