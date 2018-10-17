class ProblemPolicy < ApplicationPolicy
  def create?
    !!user&.confirmed?
  end

  def update?
    !!user&.confirmed?
  end

  def destroy?
    !!user&.confirmed?
  end

  def index?
    true
  end

  def show?
    true
  end
end
