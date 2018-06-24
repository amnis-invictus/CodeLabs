class AddProfileAttrsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :name, :string

    add_column :users, :score, :bigint, default: 0

    add_column :users, :skills, :string, array: true, default: []
  end
end
