class AddLogToResults < ActiveRecord::Migration[5.2]
  def change
    add_column :results, :log, :text
  end
end
