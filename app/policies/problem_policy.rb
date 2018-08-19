class ProblemPolicy < ApplicationPolicy
  def create?
    !!user&.administrator?
  end

  def index?
    true
  end

  def show?
    true
  end
end
