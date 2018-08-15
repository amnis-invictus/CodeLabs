class CreateCompilers < ActiveRecord::Migration[5.2]
  def change
    create_table :compilers do |t|
      t.string :name, null: false
      t.string :version, null: false

      t.timestamps
    end
  end
end
