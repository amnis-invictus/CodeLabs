class ProblemPolicy < ApplicationPolicy
  def create?
    !!user&.confirmed?
  end

  def update?
    return false if user.blank?

    user.moderator? || user == resource.user
  end

  def destroy?
    return false if user.blank?

    user.moderator? || user == resource.user
  end

  def index?
    true
  end

  def show?
    return true unless resource.private?

    return false if user.blank?

    return true if user.moderator? || user == resource.user

    user.shared_problems.include? resource
  end
end
