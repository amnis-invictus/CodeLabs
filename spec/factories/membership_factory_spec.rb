require 'rails_helper'

RSpec.describe MembershipFactory do
  subject { described_class.new :user, params }

  let(:params) { { user_id: :user_id, group: :group, type: :type } }

  it { should be_an ApplicationFactory }

  describe '#build' do
    before { expect(subject).to receive(:state).and_return(:state) }

    before do
      expect(Membership).to receive(:new).with(user_id: :user_id, group: :group, state: :state).and_return(:membership)
    end

    its(:build) { should eq :membership }
  end

  describe '#state' do
    context do
      let(:params) { { type: 'invite', group: :group } }

      its(:state) { should eq :invited }
    end

    context do
      let(:params) { { type: 'request', group: group } }

      context do
        let(:group) { stub_model Group, visibility: :public }

        its(:state) { should eq :accepted }
      end

      context do
        let(:group) { stub_model Group, visibility: :moderated }

        its(:state) { should eq :requested }
      end

      context do
        let(:group) { stub_model Group, visibility: :private }

        its(:state) { should be_nil }
      end
    end

    context do
      let(:params) { { type: 'unknown', group: :group } }

      its(:state) { should be_nil }
    end

    context do
      let(:params) { { type: 'request' } }

      its(:state) { should be_nil }
    end
  end
end
