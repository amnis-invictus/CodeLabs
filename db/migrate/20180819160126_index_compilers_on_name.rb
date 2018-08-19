class IndexCompilersOnName < ActiveRecord::Migration[5.2]
  def change
    add_index :compilers, :name
  end
end
