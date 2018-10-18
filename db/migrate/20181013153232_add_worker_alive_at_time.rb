class AddWorkerAliveAtTime < ActiveRecord::Migration[5.2]
  def change
    add_column :workers, :alive_at, :datetime

    add_index :workers, :alive_at
  end
end
