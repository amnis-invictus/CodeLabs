class SubmissionPolicy < ApplicationPolicy
  def create?
    user.present?
  end

  def show?
    user&.id == resource.user_id
  end
end
