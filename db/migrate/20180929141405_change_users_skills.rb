class ChangeUsersSkills < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :skills, :string, array: true

    add_column :users, :skills, :string
  end
end
