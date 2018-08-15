class AddCompilerToSubmissions < ActiveRecord::Migration[5.2]
  def change
    add_reference :submissions, :compiler, index: true

    add_foreign_key :submissions, :compilers

    change_column_null :submissions, :compiler_id, false, 1
  end
end
