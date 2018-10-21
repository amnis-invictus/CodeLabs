class CreateSharings < ActiveRecord::Migration[5.2]
  def change
    create_table :sharings do |t|
      t.belongs_to :group, index: true, foreign_key: true, null: false

      t.belongs_to :problem, index: true, foreign_key: true, null: false

      t.timestamps
    end
  end
end
