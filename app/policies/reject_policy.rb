class RejectPolicy < ApplicationPolicy
  def create?
    return false if user.blank?

    return false unless resource.invite_pending?

    user == resource.invite_receiver || user == resource.invite_sender
  end
end
