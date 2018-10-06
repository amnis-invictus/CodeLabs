class CreateTableGroupsUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :groups_users, id: false do |t|
      t.belongs_to :group, foreign_key: true, index: true, null: false

      t.belongs_to :user, foreign_key: true, index: true, null: false
    end
  end
end
