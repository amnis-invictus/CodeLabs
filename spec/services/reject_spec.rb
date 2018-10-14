require 'rails_helper'

RSpec.describe Reject do
  let(:sender) { double }

  let(:receiver) { double }

  let(:invite) { double sender: sender, receiver: receiver }

  subject { described_class.new invite }

  its(:invite) { should eq invite }

  it { should delegate_method(:sender).to(:invite).with_prefix }

  it { should delegate_method(:receiver).to(:invite).with_prefix }

  it { should delegate_method(:pending?).to(:invite).with_prefix }
  describe '#save' do
    it { expect(invite).to receive(:update).with(status: :rejected) }

    after { subject.save }
  end
end
