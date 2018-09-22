class AddDefaultToProblemTranslations < ActiveRecord::Migration[5.2]
  def change
    add_column :problem_translations, :default, :boolean, default: false, null: false
  end
end
