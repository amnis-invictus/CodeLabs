class AddUserIdToSubmissions < ActiveRecord::Migration[5.2]
  def change
    Submission.destroy_all

    add_reference :submissions, :user, index: true, foreign_key: true, null: false
  end
end
