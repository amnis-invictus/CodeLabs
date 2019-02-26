class RemoveGroupsUsersAndInvites < ActiveRecord::Migration[5.2]
  def change
    drop_table :groups_users

    drop_table :invites
  end
end
