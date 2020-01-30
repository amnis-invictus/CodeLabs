class PasswordPolicy < ApplicationPolicy
  def update?
    user.blank? && resource.present?
  end
end
