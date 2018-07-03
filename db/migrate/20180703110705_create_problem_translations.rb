class CreateProblemTranslations < ActiveRecord::Migration[5.2]
  def change
    create_table :problem_translations do |t|
      t.integer :language
      t.string :caption
      t.string :author
      t.text :text
      t.text :technical_text
      t.belongs_to :problem, index: true, foreign_key: true, null: false

      t.timestamps
    end
  end
end
