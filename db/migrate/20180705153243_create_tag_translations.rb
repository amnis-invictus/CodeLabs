class CreateTagTranslations < ActiveRecord::Migration[5.2]
  def change
    create_table :tag_translations do |t|
      t.integer :language
      t.string :name
      t.belongs_to :tag, index: true, foreign_key: true, null: false

      t.timestamps
    end
  end
end
