class AddIndexTestsOnNum < ActiveRecord::Migration[5.2]
  def change
    add_index :tests, :num
  end
end
