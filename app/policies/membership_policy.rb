class MembershipPolicy < ApplicationPolicy
  def index?
    return false if user.blank?

    params[:parent] ? user == params[:parent].owner : true
  end

  def create?
    return false if user.blank?

    return true if resource.contest.blank? || resource.user.blank? || resource.state.blank? # should be validation errors

    case resource.state
    when 'invited'
      return true if user == resource.contest.owner

      resource.contest.visibility_public? && resource.contest.accepted_users.include?(user)
    when 'requested'
      resource.contest.visibility_moderated? && user == resource.user
    when 'accepted'
      resource.contest.visibility_public? && user == resource.user
    end
  end

  def destroy?
    return false if user.blank?

    user == resource.user || user == resource.contest.owner
  end

  def update?
    return false if user.blank?

    case resource.state
    when 'requested'
      user == resource.contest.owner
    when 'invited'
      user == resource.user
    end
  end
end
