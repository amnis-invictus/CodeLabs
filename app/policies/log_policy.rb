class LogPolicy < ApplicationPolicy
  def create?
    resource.submission.test_state_in_progress?
  end

  def show?
    return false if user.blank?

    return true if user.administrator?

    return true if resource.source? && resource.submission_user == user

    resource.submission_problem_user == user
  end
end
