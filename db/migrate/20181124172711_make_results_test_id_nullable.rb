class MakeResultsTestIdNullable < ActiveRecord::Migration[5.2]
  def change
    change_column_null :results, :test_id, true
  end
end
