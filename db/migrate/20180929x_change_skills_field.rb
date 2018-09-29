class ChangeSkillsField < ActiveRecord::Migration[5.2]
  def change
    remove_column(:users, :skills)

    add_column(:users, :skills, :string)
  end
end
