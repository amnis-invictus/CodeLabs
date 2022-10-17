class AddIndexGroupsOnStartsAtEndsAt < ActiveRecord::Migration[5.2]
  def change
    add_index :groups, :starts_at
    add_index :groups, :ends_at
  end
end
