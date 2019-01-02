class AvatarPolicy < ApplicationPolicy
  def create?
    return false if user.blank?

    user == resource.user
  end

  def destroy?
    return false if user.blank?

    user == resource.user
  end
end
