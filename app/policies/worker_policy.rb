class WorkerPolicy < ApplicationPolicy
  def index?
    !!user&.administrator?
  end
end
