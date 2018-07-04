class RenameSubmissionsSolutionCompilerToCompiler < ActiveRecord::Migration[5.2]
  def change
    rename_column :submissions, :solution_compiler, :compiler
  end
end
