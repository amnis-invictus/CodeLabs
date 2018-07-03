class AddForeignKeyAndNotNullToAuthTokensUserId < ActiveRecord::Migration[5.2]
  def change
    add_foreign_key :auth_tokens, :users

    change_column_null :auth_tokens, :user_id, false
  end
end
