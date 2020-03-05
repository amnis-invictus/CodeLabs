class AddPasswordRecoveryTokenToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :password_recovery_token, :uuid

    add_index :users, :password_recovery_token, unique: true
  end
end
