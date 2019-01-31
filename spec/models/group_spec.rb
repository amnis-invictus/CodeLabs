require 'rails_helper'

RSpec.describe Group, type: :model do
  it { should validate_presence_of :name }

  it { should validate_presence_of :visibility }

  it { should belong_to(:owner).class_name('User') }

  it { should have_many(:invites).dependent(:destroy) }

  it { should have_many(:sharings).dependent(:destroy) }

  it { should have_many(:problems).through(:sharings) }

  it { should have_many(:submissions).through(:users) }

  it { should have_and_belong_to_many :users }

  it { should define_enum_for(:visibility).with_values(private: 0, moderated: 1, public: 2).with_prefix }
end
