class AddMemoryAndTimeToResults < ActiveRecord::Migration[5.2]
  def change
    add_column :results, :memory, :float, null: :false

    add_column :results, :time, :float, null: :false
  end
end
