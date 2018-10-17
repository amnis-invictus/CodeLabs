class CreateGroupsProblems < ActiveRecord::Migration[5.2]
  def change
    create_table :groups_problems, id: false do |t|
      t.belongs_to :group, index: true, foreign_key: true, null: false

      t.belongs_to :problem, index: true, foreign_key: true, null: false
    end
  end
end
