class CreateAuthTokens < ActiveRecord::Migration[5.2]
  def change
    create_table :auth_tokens, id: :uuid do |t|
      t.belongs_to :user, index: true

      t.timestamps
    end
  end
end
