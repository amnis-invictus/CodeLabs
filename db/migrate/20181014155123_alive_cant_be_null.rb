class AliveCantBeNull < ActiveRecord::Migration[5.2]
  def change
    change_column_null :workers, :alive_at, false
  end
end
