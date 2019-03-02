class LogPolicy < ApplicationPolicy
  def create?
    resource.submission.test_state_in_progress?
  end

  def show?
    return false if user.blank?
    
    return true if user.administrator?
    
    return true if resource.source? && resource.submission.user == user
    
    resource.submission.problem.user == user
  end
end
