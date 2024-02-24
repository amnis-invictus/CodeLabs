require 'rails_helper'

RSpec.describe MembershipFactory do
  subject { described_class.new :current_user, params }

  let(:params) { { user_id: :user_id, contest: :contest, type: :type } }

  it { should be_an ApplicationFactory }

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
end
