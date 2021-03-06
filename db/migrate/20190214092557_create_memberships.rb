class CreateMemberships < ActiveRecord::Migration[5.2]
  def change
    create_table :memberships do |t|
      t.belongs_to :user, foreign_key: true, index: true

      t.belongs_to :group, foreign_key: true, index: true

      t.integer :state, null: false

      t.timestamps
    end
  end
end
