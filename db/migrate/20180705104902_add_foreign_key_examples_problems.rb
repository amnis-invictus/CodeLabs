class AddForeignKeyExamplesProblems < ActiveRecord::Migration[5.2]
  def change
    add_foreign_key :examples, :problems
  end
end
