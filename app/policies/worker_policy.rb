class WorkerPolicy < ApplicationPolicy
  def index?
    !!user&.administrator?
  end

  def destroy?
    !!user&.administrator?
  end

  def create?
    true
  end

  def update?
    true
  end
end
