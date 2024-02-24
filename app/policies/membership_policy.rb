class MembershipPolicy < ApplicationPolicy
  def index?
    return false if user.blank?

    true
  end
end
