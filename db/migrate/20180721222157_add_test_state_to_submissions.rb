class AddTestStateToSubmissions < ActiveRecord::Migration[5.2]
  def change
    add_column :submissions, :test_state, :integer, default: 0, null: false

    add_index :submissions, :test_state
  end
end
