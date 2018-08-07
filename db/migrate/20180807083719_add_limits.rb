class AddLimits < ActiveRecord::Migration[5.2]
  def change
    add_column :compilers, :memory_a, :float

    add_column :compilers, :memory_b, :float

    add_column :compilers, :time_a, :float

    add_column :compilers, :time_b, :float

    add_column :problems, :memory_limit, :float

    add_column :problems, :time_limit, :float

    change_column_null :compilers, :memory_a, false, 1

    change_column_null :compilers, :memory_b, false, 0

    change_column_null :compilers, :time_a, false, 1

    change_column_null :compilers, :time_b, false, 0

    change_column_null :problems, :memory_limit, false, 32*1024

    change_column_null :problems, :time_limit, false, 100
  end
end
