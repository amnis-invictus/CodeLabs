class SessionPolicy < ApplicationPolicy
  def create?
    user.blank?
  end

  def destroy?
    user.present?
  end
end
