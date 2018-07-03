class CreateTests < ActiveRecord::Migration[5.2]
  def change
    create_table :tests do |t|
      t.string :test_num
      t.belongs_to :problem, foregin_key: true, index: true, null: false

      t.timestamps
    end
  end
end
