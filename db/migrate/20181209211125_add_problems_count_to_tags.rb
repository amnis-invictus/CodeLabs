class AddProblemsCountToTags < ActiveRecord::Migration[5.2]
  def change
    add_column :tags, :problems_count, :integer, default: 0, null: false, index: true
  end
end
