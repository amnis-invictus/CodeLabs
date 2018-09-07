class FixNotNullForResultsMemotyAndTime < ActiveRecord::Migration[5.2]
  def change
    change_column_null :results, :memory, false, 0

    change_column_null :results, :time, false, 0
  end
end
