class CreateConfirmationRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :confirmation_requests do |t|
      t.belongs_to :user, foreign_key: true, index: true, null: false

      t.integer :status, default: 0, null: false

      t.timestamps
    end
  end
end
