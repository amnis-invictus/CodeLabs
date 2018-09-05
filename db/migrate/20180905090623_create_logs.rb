class CreateLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :logs do |t|
      t.text :data, null: false
      t.integer :type, null: false
      t.belongs_to :submission, foregin_key: true, index: true, null: false

      t.timestamps
    end
  end
end
