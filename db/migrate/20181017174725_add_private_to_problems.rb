class AddPrivateToProblems < ActiveRecord::Migration[5.2]
  def change
    add_column :problems, :private, :boolean, null: false, default: false
  end
end
