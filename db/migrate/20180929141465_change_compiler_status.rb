class ChangeCompilerStatus < ActiveRecord::Migration[5.2]
  def change
    add_column :compilers, :status, :integer, default: 0

    remove_column :compilers, :visible
  end
end
