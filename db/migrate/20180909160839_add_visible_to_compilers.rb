class AddVisibleToCompilers < ActiveRecord::Migration[5.2]
  def change
    add_column :compilers, :visible, :boolean, default: false, null: false

    add_index :compilers, :visible
  end
end
