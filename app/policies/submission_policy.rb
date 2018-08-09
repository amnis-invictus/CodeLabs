class SubmissionPolicy < ApplicationPolicy
  def index?
    true
  end

  def create?
    user.present?
  end

  def show?
    user&.id == resource.user_id
  end
end
