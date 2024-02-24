class CreateRealGroups < ActiveRecord::Migration[6.1]
  def change
    create_table :groups do |t|
      t.string 'name', null: false

      t.text 'description'

      t.integer 'visibility', default: 0, null: false

      t.timestamps
    end

    add_column :memberships, :role, :bigint, default: 0
  end
end
