class RemoveCompilerEnumFromSubmissions < ActiveRecord::Migration[5.2]
  def change
    remove_column :submissions, :compiler
  end
end
