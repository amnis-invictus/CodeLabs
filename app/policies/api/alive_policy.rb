class Api::AlivePolicy < ApplicationPolicy
  def create?
    !resource.worker_disabled?
  end
end
