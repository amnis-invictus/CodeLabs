require 'rails_helper'

RSpec.describe Invite, type: :model do
  fixtures :users, :groups

  subject { described_class.new sender: users(:one), receiver: users(:three), group: groups(:one) }

  it { should validate_uniqueness_of(:receiver).scoped_to(:group_id) }

  it { should belong_to :group }

  it { should belong_to(:sender).class_name('User') }

  it { should belong_to(:receiver).class_name('User') }

  it { should define_enum_for(:status).with(pending: 0, accepted: 1, rejected: 2) }

  it { should delegate_method(:visibility).to(:group).with_prefix }

  it { should delegate_method(:owner).to(:group).with_prefix }

  it { should delegate_method(:name).to(:sender).with_prefix }

  it { should delegate_method(:name).to(:receiver).with_prefix }
end
