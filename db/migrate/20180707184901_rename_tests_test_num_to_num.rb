class RenameTestsTestNumToNum < ActiveRecord::Migration[5.2]
  def change
    rename_column :tests, :test_num, :num
  end
end
