class AddTestResultToSubmissions < ActiveRecord::Migration[5.2]
  def change
    add_column :submissions, :test_result, :integer
  end
end
