class ConfirmationRequest::RejectPolicy < ApplicationPolicy
  def create?
    return false if user.blank?

    return false unless resource.confirmation_request_pending?

    user.moderator?
  end
end
