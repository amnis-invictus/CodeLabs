class SubmissionSearcher < ApplicationSearcher
  def search_by_problem_id problem_id
    relation.where problem_id: problem_id
  end

  def search_by_user_id user_id
    relation.where user_id: user_id
  end

  def search_by_group_id group_id
    relation.joins(user: :accepted_memberships).where(memberships: { group_id: group_id })
  end
end
