class Invite::AcceptPolicy < ApplicationPolicy
  def create?
    return false if user.blank?

    return false unless resource.invite_pending?

    user == resource.invite_receiver
  end
end
