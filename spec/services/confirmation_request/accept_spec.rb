require 'rails_helper'

RSpec.describe ConfirmationRequest::Accept do
  let(:confirmation_request) { stub_model ConfirmationRequest }

  subject { described_class.new confirmation_request }

  its(:confirmation_request) { should eq confirmation_request }

  it { should delegate_method(:pending?).to(:confirmation_request).with_prefix }

  describe '#save' do
    let(:user) { double }

    before { allow(confirmation_request).to receive(:user).and_return(user) }

    before { expect(ConfirmationRequest).to receive(:transaction).and_yield }

    before { expect(user).to receive(:update).with(roles: :confirmed) }

    before { expect(confirmation_request).to receive(:update).with(status: :accepted).and_return(:result) }

    its(:save) { should eq :result }
  end
end
