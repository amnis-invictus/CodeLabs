class UserPolicy < ApplicationPolicy
  def create?
    !user.present?
  end

  def show?
    user.id == resource.id
  end

  def update?
    user.id == resource.id
  end
end
