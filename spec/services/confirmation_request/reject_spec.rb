require 'rails_helper'

RSpec.describe ConfirmationRequest::Reject do
  let(:confirmation_request) { stub_model ConfirmationRequest }

  subject { described_class.new confirmation_request }

  its(:confirmation_request) { should eq confirmation_request }

  it { should delegate_method(:pending?).to(:confirmation_request).with_prefix }

  describe '#save' do
    before { expect(confirmation_request).to receive(:update).with(status: :rejected).and_return(:result) }

    its(:save) { should eq :result }
  end
end
