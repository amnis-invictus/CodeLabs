class CompilerPolicy < ApplicationPolicy
  def create?
    !!user&.administrator?
  end

  def index?
    !!user&.administrator?
  end

  def show?
    !!user&.administrator?
  end

  def update?
    !!user&.administrator?
  end

  def destroy?
    !!user&.administrator? && resource.persisted?
  end
end
