class CreateGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :groups do |t|
      t.string :name, null: false

      t.integer :visibility, null: false, default: 0

      t.belongs_to :owner, foreign_key: { to_table: :users }, index: true, null: false

      t.timestamps
    end
  end
end
