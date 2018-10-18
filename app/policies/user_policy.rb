class UserPolicy < ApplicationPolicy
  def index?
    true
  end

  def create?
    !user.present?
  end

  def show?
    return false if user.blank?

    user.id == resource.id
  end

  def update?
    return false if user.blank?

    user.id == resource.id
  end
end
