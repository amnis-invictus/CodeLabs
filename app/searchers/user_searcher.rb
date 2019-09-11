class UserSearcher < ApplicationSearcher
  def search_by_query query
    relation.where 'username ILIKE :query OR name ILIKE :query', query: "%#{ query }%" if query.present?
  end
end
