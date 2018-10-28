class AddPointsForTest < ActiveRecord::Migration[5.2]
  def change
    add_column :tests, :point, :integer, null: false, default: 1
  end
end
