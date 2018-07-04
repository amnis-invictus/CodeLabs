class RenameTableTestRequestToSubmissions < ActiveRecord::Migration[5.2]
  def change
    rename_table :test_requests, :submissions
  end
end
