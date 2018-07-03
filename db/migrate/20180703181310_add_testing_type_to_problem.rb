class AddTestingTypeToProblem < ActiveRecord::Migration[5.2]
  def change
    add_column :problems, :testing_type, :integer, null: false
  end
end
