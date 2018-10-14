class UserSearcher < ApplicationSearcher
  def search_by_username username
    relation.where 'username ILIKE ?', "%#{ username }%" if username.present?
  end
end
