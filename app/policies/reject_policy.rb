class RejectPolicy < ApplicationPolicy
  def create?
    return false if user.blank?

    user == resource.invite_receiver || user == resource.invite_sender
  end
end
