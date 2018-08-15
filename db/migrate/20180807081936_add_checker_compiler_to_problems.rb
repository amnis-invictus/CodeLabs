class AddCheckerCompilerToProblems < ActiveRecord::Migration[5.2]
  def change
    add_reference :problems, :checker_compiler, index: true

    add_foreign_key :problems, :compilers, column: :checker_compiler_id

    change_column_null :problems, :checker_compiler_id, false, 1
  end
end
