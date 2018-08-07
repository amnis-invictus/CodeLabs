class CreateResults < ActiveRecord::Migration[5.2]
  def change
    create_table :results do |t|
      t.integer :status, null: false
      t.belongs_to :submission, foregin_key: true, index: true, null: false
      t.belongs_to :test, foregin_key: true, index: true, null: false

      t.timestamps
    end
  end
end
