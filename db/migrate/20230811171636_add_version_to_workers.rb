class AddVersionToWorkers < ActiveRecord::Migration[6.1]
  def change
    add_column :workers, :version, :string, null: false
  end
end
