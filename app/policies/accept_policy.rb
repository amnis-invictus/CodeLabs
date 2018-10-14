class AcceptPolicy < ApplicationPolicy
  def create?
    return false if user.blank?

    user == resource.invite_receiver
  end
end
