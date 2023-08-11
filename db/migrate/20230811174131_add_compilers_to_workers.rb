class AddCompilersToWorkers < ActiveRecord::Migration[6.1]
  def change
    add_column :workers, :active_compilers, :integer, array: true, default: [], null: false

    add_column :workers, :ignored_compilers, :integer, array: true, default: [], null: false
  end
end
