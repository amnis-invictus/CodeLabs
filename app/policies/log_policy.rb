class LogPolicy < ApplicationPolicy
  def create?
    resource.submission.test_state_in_progress?
  end
end
