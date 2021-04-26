class CreateTestLibs < ActiveRecord::Migration[5.2]
  def change
    create_table :test_libs do |t|
      t.integer :version, array: true, null: false, index: { unique: true }

      t.timestamps
    end
  end
end
