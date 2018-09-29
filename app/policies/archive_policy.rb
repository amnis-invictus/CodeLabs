class ArchivePolicy < ApplicationPolicy
  def create?
    !!user&.administrator?
  end
end
