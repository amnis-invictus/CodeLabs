class AddUsernameToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :username, :string

    change_column_null :users, :username, false, -> { 'gen_random_uuid()' }

    add_index :users, :username, using: :gist, opclass: :gist_trgm_ops
  end
end
