class AddOwnerToProblems < ActiveRecord::Migration[5.2]
  def change
    add_reference :problems, :user, index: true, foreign_key: true
  end
end
