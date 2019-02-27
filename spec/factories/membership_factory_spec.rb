require 'rails_helper'

RSpec.describe MembershipFactory do
  subject { described_class.new :current_user, params }

  let(:params) { { user_id: :user_id, group: :group, type: :type } }

  it { should be_an ApplicationFactory }

  describe '#build' do
    before { expect(subject).to receive(:user).and_return(:user) }

    before { expect(subject).to receive(:state).and_return(:state) }

    before do
      expect(Membership).to receive(:new).with(user: :user, group: :group, state: :state).and_return(:membership)
    end

    its(:build) { should eq :membership }
  end

  describe '#user' do
    context do
      let(:params) { { user_id: 6, type: 'invite' } }

      before { expect(User).to receive(:find_by).with(id: 6).and_return(:user) }

      its(:user) { should eq :user }
    end

    context do
      let(:params) { { type: 'request' } }

      before { expect(User).to_not receive(:find_by) }

      its(:user) { should eq :current_user }
    end

    context do
      let(:params) { { type: 'unknown' } }

      before { expect(User).to_not receive(:find_by) }

      its(:user) { should be_nil }
    end
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
