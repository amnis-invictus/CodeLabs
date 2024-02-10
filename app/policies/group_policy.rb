class GroupPolicy < ApplicationPolicy
  def index?
    user.present?
  end

  def create?
    !!user&.confirmed?
  end

  def update?
    return false if user.blank?

    resource.owner_memberships.exists? user: user
  end

  def destroy?
    return false if user.blank?

    resource.owner_memberships.exists? user: user
  end

  def show?
    return false if user.blank?

    return true if resource.visibility_moderated? || resource.visibility_public?

    return true if resource.owner_memberships.exists? user: user

    resource.accepted_users.include? user
  end

  def new_invite?
    return false if user.blank?

    return true if resource.owner_memberships.exists? user: user

    resource.visibility_public? && resource.accepted_users.include?(user)
  end

  def index_memberships?
    return false if user.blank?

    resource.owner_memberships.exists? user: user
  end
end
