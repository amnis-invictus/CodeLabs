class MembershipPolicy < ApplicationPolicy
  def destroy?
    return false if user.blank?

    user == resource.group_owner
  end
end
