class RenameGroupsToContests < ActiveRecord::Migration[6.1]
  def change
    rename_table :groups, :contests

    rename_column :memberships, :group_id, :contest_id

    rename_column :sharings, :group_id, :contest_id
  end
end
