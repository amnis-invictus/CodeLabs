class CreateWorkers < ActiveRecord::Migration[5.2]
  def change
    create_table :workers, id: :uuid do |t|
      t.string :name, null: false
      t.string :ips, array: true, default: [], null: false
      t.integer :api_version, null: false
      t.integer :api_type, null: false
      t.boolean :webhook_supported, null: false
      t.string :task_status, array: true, default: [], null: false
      t.integer :status, default: 0, null: false

      t.timestamps
    end
  end
end
