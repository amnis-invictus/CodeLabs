class MakeSubmissionUserNotRequired < ActiveRecord::Migration[5.2]
  def change
    change_column_null :submissions, :user_id, true
  end
end
