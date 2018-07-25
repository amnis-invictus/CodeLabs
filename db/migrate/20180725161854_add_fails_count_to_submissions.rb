class AddFailsCountToSubmissions < ActiveRecord::Migration[5.2]
  def change
    add_column :submissions, :fails_count, :integer, default: 0, null: false
  end
end
