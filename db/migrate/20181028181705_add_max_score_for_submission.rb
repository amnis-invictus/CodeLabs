class AddMaxScoreForSubmission < ActiveRecord::Migration[5.2]
  def change
    add_column :submissions, :max_score, :float
  end
end
