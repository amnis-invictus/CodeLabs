class AddStatusToInvite < ActiveRecord::Migration[5.2]
  def change
    add_column :invites, :status, :integer, null: false, default: 0
  end
end
