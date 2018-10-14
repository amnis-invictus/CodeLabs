require 'rails_helper'

RSpec.describe Accept do
  let(:sender) { double }

  let(:receiver) { double }

  let(:group_users) { [] }

  let(:invite) { double sender: sender, receiver: receiver }

  before { allow(invite).to receive(:group_users).and_return(group_users) }

  subject { described_class.new invite }

  its(:invite) { should eq invite }

  its(:invite_sender) { should eq sender }

  its(:invite_receiver) { should eq receiver }

  describe '#save' do
    before { expect(invite).to receive(:update).with(status: :accepted) }

    it { expect { subject.save }.to change { group_users }.to [receiver] }
  end
end
