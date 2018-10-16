class Api::Worker::SessionPolicy < ApplicationPolicy
  def create?
    resource.worker_disabled?
  end

  def destroy?
    !resource.worker_disabled?
  end
end
