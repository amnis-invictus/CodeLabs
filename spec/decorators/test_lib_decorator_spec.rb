require 'rails_helper'

RSpec.describe TestLibDecorator do
  let(:resource) { stub_model TestLib, version: [1, 0, 7_784, 34_987] }

  subject { resource.decorate }

  its(:version) { should eq '1.0.7784.34987' }

  describe '#as_json' do
    before { expect(subject).to receive(:binary_url).and_return(:binary_url) }

    its(:as_json) { should eq version: '1.0.7784.34987', binary_url: :binary_url }
  end

  describe '#binary_url' do
    before { allow(resource).to receive(:binary).and_return(binary) }

    context do
      let(:binary) { double attached?: true }

      before do
        expect(subject).to receive_message_chain(:helpers, :full_url_for).with(binary).and_return('http://test.host/binary')
      end

      its(:binary_url) { should eq 'http://test.host/binary' }
    end

    context do
      let(:binary) { double attached?: false }

      its(:binary_url) { should be_nil }
    end
  end
end
