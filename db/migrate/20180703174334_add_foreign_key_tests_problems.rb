class AddForeignKeyTestsProblems < ActiveRecord::Migration[5.2]
  def change
    add_foreign_key :tests, :problems
  end
end
