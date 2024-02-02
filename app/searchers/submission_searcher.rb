class SubmissionSearcher < ApplicationSearcher
  def search_by_problem_id problem_id
    relation.where problem_id: problem_id
  end

  def search_by_user_id user_id
    relation.where user_id: user_id
  end

  def search_by_contest_id contest_id
    relation.joins(user: :accepted_memberships).where(memberships: { contest_id: contest_id })
  end
end
