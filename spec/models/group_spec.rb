require 'rails_helper'

RSpec.describe Group, type: :model do
  it { should validate_presence_of :name }

  it { should validate_presence_of :visibility }

  it { should belong_to(:owner).class_name('User') }

  it { should have_many(:sharings).dependent(:destroy) }

  it { should have_many(:pending_memberships).class_name('Membership').dependent(:destroy) }

  it { should have_many(:accepted_memberships).conditions(state: :accepted).class_name('Membership').dependent(:destroy) }

  it { should have_many(:problems).through(:sharings).order(:id) }

  it { should have_many(:pending_users).through(:pending_memberships).source(:user).class_name('User') }

  it { should have_many(:accepted_users).through(:accepted_memberships).source(:user).class_name('User') }

  it { should have_many(:submissions).through(:accepted_users) }

  it { should define_enum_for(:visibility).with_values(private: 0, moderated: 1, public: 2).with_prefix }
end
