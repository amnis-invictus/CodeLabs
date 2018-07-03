class CreateTestRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :test_requests do |t|
      t.integer :solution_compiler, null: false
      t.belongs_to :problem, index: true, foreign_key: true, null: false

      t.timestamps
    end
  end
end
