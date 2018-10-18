class GroupPolicy < ApplicationPolicy
  def index?
    user.present?
  end

  def show?
    return false if user.blank?

    return true if user == resource.owner

    resource.users.include? user
  end

  def create?
    user.present?
  end

  def update?
    return false if user.blank?

    user == resource.owner
  end

  def destroy?
    return false if user.blank?

    user == resource.owner
  end
end
