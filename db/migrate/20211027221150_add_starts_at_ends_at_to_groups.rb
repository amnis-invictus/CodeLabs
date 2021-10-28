class AddStartsAtEndsAtToGroups < ActiveRecord::Migration[5.2]
  def change
    add_column :groups, :starts_at, :datetime
    add_column :groups, :ends_at, :datetime
  end
end
