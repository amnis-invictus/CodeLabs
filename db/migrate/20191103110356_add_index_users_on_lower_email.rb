class AddIndexUsersOnLowerEmail < ActiveRecord::Migration[5.2]
  def change
    add_index :users, 'lower(email)'
  end
end
