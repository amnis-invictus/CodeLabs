class CreateInvites < ActiveRecord::Migration[5.2]
  def change
    create_table :invites do |t|
      t.belongs_to :sender, foreign_key: { to_table: :users }, index: true, null: false

      t.belongs_to :receiver, foreign_key: { to_table: :users }, index: true, null: false

      t.belongs_to :group, foreign_key: true, index: true, null: false

      t.timestamps
    end
  end
end
