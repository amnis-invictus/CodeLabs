class SubmissionPolicy < ApplicationPolicy
  def index?
    true
  end

  def create?
    return false if user.blank?

    return true unless resource.problem_private?

    return true if user.moderator? || user == resource.problem_user

    user.shared_problems.include? resource.problem
  end

  def show?
    return false if user.blank?

    return true if user.administrator? || user == resource.user || user == resource.problem_user

    owned_groups_ids = user.owned_groups_memberships.select :membershipable_id
    Membership.exists? user: resource.user, state: :accepted, membershipable_type: 'Group',
      membershipable_id: owned_groups_ids
  end

  def destroy?
    !!user&.administrator?
  end
end
