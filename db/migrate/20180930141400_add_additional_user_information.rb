class AddAdditionalUserInformation < ActiveRecord::Migration[5.2]
  def change
    enable_extension 'pg_trgm'

    add_column :users, :city, :string

    add_index :users, :city, using: :gist, opclass: :gist_trgm_ops

    add_column :users, :institution, :string

    add_index :users, :institution, using: :gist, opclass: :gist_trgm_ops
  end
end
