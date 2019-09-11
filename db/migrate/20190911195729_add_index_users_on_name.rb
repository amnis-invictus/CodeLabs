class AddIndexUsersOnName < ActiveRecord::Migration[5.2]
  def change
    add_index :users, :name, using: :gist, opclass: :gist_trgm_ops
  end
end
