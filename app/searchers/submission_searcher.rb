class SubmissionSearcher < ApplicationSearcher
  def search_by_problem problem
    relation.where problem:
  end

  def search_by_user user
    relation.where user:
  end

  def search_by_contest contest
    relation.joins(user: :accepted_memberships).where(memberships: { membershipable: contest })
  end

  def search_by_group group
    relation.joins(user: :accepted_memberships).where(memberships: { membershipable: group })
  end
end
