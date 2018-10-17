class RemoveAdmnistratorFromUsers < ActiveRecord::Migration[5.2]
  def change
    User.where(administrator: true).update_all(roles: 4)

    remove_column :users, :administrator
  end
end
