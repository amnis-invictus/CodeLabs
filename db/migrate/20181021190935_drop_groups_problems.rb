class DropGroupsProblems < ActiveRecord::Migration[5.2]
  def change
    drop_table :groups_problems
  end
end
