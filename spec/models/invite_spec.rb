require 'rails_helper'

RSpec.describe Invite, type: :model do
  fixtures :users, :groups

  context do
    subject { described_class.new sender: users(:one), receiver: users(:three), group: groups(:one) }

    before { allow_any_instance_of(described_class).to receive(:receiver_must_not_be_in_group) }

    it { should validate_uniqueness_of(:receiver).scoped_to(:group_id) }
  end

  it { should belong_to :group }

  it { should belong_to(:sender).class_name('User') }

  it { should belong_to(:receiver).class_name('User') }

  it { should define_enum_for(:status).with(pending: 0, accepted: 1, rejected: 2) }

  it { should delegate_method(:name).to(:group).with_prefix }

  it { should delegate_method(:visibility).to(:group).with_prefix }

  it { should delegate_method(:owner).to(:group).with_prefix }

  it { should delegate_method(:users).to(:group).with_prefix }

  it { should delegate_method(:name).to(:sender).with_prefix }

  it { should delegate_method(:name).to(:receiver).with_prefix }

  describe '#receiver_must_not_be_in_group' do
    before { subject.valid? }

    context do
      subject { described_class.new status: :accepted }

      its('errors.details') { should include :receiver }
    end

    context do
      subject { described_class.new status: :rejected }

      its('errors.details') { should include :receiver }
    end

    context do
      subject { described_class.new receiver: users(:one), group: groups(:one) }

      its('errors.details') { should include receiver: [error: :exists] }
    end

    context do
      subject { described_class.new receiver: users(:three), group: groups(:one) }

      its('errors.details') { should_not include :receiver }
    end
  end
end
