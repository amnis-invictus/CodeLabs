class Submission::RetestPolicy < ApplicationPolicy
  def create?
    !!user&.administrator?
  end
end
