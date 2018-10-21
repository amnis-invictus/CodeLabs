class SharingPolicy < ApplicationPolicy
  def new?
    return false if user.blank?

    user == resource.group_owner
  end

  def create?
    return false if user.blank?

    user == resource.group_owner && user == resource.problem_user
  end
end
