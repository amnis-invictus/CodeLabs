class ProblemSearcher < ApplicationSearcher
  def search_by_user_id user_id
    relation.where user_id:
  end

  def search_by_tag_id tag_id
    relation.joins(:problems_tags).where(problems_tags: { tag_id: })
  end

  def search_by_contest_id contest_id
    relation.joins(:sharings).where(sharings: { contest_id: })
  end

  def search_by_query query
    relation.where id: ProblemTranslation.where('caption ILIKE ?', "%#{ query }%").select(:problem_id)
  end
end
