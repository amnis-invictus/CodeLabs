class MakeMembershipBelongsToMembershipablePolymorphic < ActiveRecord::Migration[6.1]
  def change
    add_column :memberships, :type, :string

    change_column_null :memberships, :type, false, 'ContestMembership'

    add_column :memberships, :membershipable_type, :string

    change_column_null :memberships, :membershipable_type, false, 'Contest'

    remove_foreign_key :memberships, :contests

    remove_index :memberships, :contest_id

    rename_column :memberships, :contest_id, :membershipable_id

    add_index :memberships, %i[membershipable_id membershipable_type]
  end
end
