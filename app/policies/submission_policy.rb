class SubmissionPolicy < ApplicationPolicy
  def index?
    true
  end

  def create?
    user.present?
  end

  def show?
    return false if user.blank?

    user.administrator? || user == resource.user || user == resource.problem_user
  end
end
