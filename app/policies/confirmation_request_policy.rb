class ConfirmationRequestPolicy < ApplicationPolicy
  def create?
    return false if user.blank? || user.roles?

    user.reload.confirmation_request.blank?
  end

  def index?
    !!user&.administrator?
  end
end
