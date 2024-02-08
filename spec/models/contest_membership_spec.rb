require 'rails_helper'

RSpec.describe ContestMembership, type: :model do
  it { should validate_presence_of :state }

  # TODO: FIX ME!
  # pending { should validate_uniqueness_of(:user).scoped_to(:membershipable_id, :membershipable_type) }

  it { should belong_to(:user).required }

  it { should belong_to(:membershipable).required }

  it { should define_enum_for(:state).with_values(%i[requested invited accepted]).with_prefix }

  describe '#user_must_not_be_contest_owner' do
    fixtures :users

    subject { stub_model described_class, contest: contest, user: users(:two) }

    before { subject.valid? }

    context do
      let(:contest) { nil }

      its('errors.details.to_h') { should_not include :user }
    end

    context do
      let(:contest) { stub_model Contest, owner: users(:one) }

      its('errors.details.to_h') { should_not include :user }
    end

    context do
      let(:contest) { stub_model Contest, owner: users(:two) }

      its('errors.details.to_h') { should include user: [error: :taken] }
    end
  end
end
