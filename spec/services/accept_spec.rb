require 'rails_helper'

RSpec.describe Accept do
  let(:sender) { double }

  let(:receiver) { double }

  let(:group_users) { [] }

  let(:invite) { double sender: sender, receiver: receiver }

  before { allow(invite).to receive(:group_users).and_return(group_users) }

  subject { described_class.new invite }

  its(:invite) { should eq invite }

 it { should delegate_method(:sender).to(:invite).with_prefix }

 it { should delegate_method(:receiver).to(:invite).with_prefix }

 it { should delegate_method(:pending?).to(:invite).with_prefix }

  describe '#save' do
    before { expect(invite).to receive(:update).with(status: :accepted) }

    it { expect { subject.save }.to change { group_users }.to [receiver] }
  end
end
