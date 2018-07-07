class CreateExamples < ActiveRecord::Migration[5.2]
  def change
    create_table :examples do |t|
      t.string :input
      t.string :answer
      t.belongs_to :problem, foregin_key: true, index: true, null: false

      t.timestamps
    end
  end
end
