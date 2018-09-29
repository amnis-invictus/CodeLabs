class AddRealTimeLimitToProblems < ActiveRecord::Migration[5.2]
  def change
    add_column :problems, :real_time_limit, :float

    change_column_null :problems, :real_time_limit, false, 5000
  end
end
