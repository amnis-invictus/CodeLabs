require 'rails_helper'

RSpec.describe Reject do
  let(:sender) { double }

  let(:receiver) { double }

  let(:invite) { double sender: sender, receiver: receiver }

  subject { described_class.new invite }

  its(:invite) { should eq invite }

  its(:invite_sender) { should eq sender }

  its(:invite_receiver) { should eq receiver }

  describe '#save' do
    it { expect(invite).to receive(:update).with(status: :rejected) }

    after { subject.save }
  end
end
