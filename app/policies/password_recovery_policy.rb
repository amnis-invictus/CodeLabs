class PasswordRecoveryPolicy < ApplicationPolicy
  def create?
    user.blank?
  end
end
