require 'rails_helper'

RSpec.describe Membership, type: :model do
  it { should validate_presence_of :state }

  pending { should validate_uniqueness_of(:user).scoped_to(:group) }

  it { should belong_to(:user).required }

  it { should belong_to(:group).required }

  it { should define_enum_for(:state).with_values(%i[requested invited accepted]).with_prefix }

  describe '#user_must_not_be_group_owner' do
    fixtures :users

    subject { stub_model described_class, group: group, user: users(:two) }

    before { subject.valid? }

    context do
      let(:group) { nil }

      its('errors.details.to_h') { should_not include :user }
    end

    context do
      let(:group) { stub_model Group, owner: users(:one) }

      its('errors.details.to_h') { should_not include :user }
    end

    context do
      let(:group) { stub_model Group, owner: users(:two) }

      its('errors.details.to_h') { should include user: [error: :taken] }
    end
  end
end
