class SubmissionPolicy < ApplicationPolicy
  def index?
    true
  end

  def create?
    return false if user.blank?

    return true unless resource.problem_private?

    return true if user.moderator? || user == resource.problem_user

    user.shared_problems.include? resource.problem
  end

  def show?
    return false if user.blank?

    user.administrator? || user == resource.user || user == resource.problem_user
  end

  def destroy?
    return false if user.blank?

    user.administrator?
  end
end
