require 'rails_helper'

RSpec.describe TestDecorator do
  let(:resource) { stub_model Test, id: 21, num: '10 A' }

  subject { resource.decorate }

  describe '#as_json' do
    before { expect(subject).to receive(:input_url).and_return(:input_url) }

    before { expect(subject).to receive(:answer_url).and_return(:answer_url) }

    its(:as_json) { should eq id: 21, num: '10 A', input_url: :input_url, answer_url: :answer_url }
  end

  describe '#input_url' do
    before { allow(subject).to receive(:input).and_return(input) }

    context do
      let(:input) { double attached?: false }

      its(:input_url) { should be_nil }
    end

    context do
      let(:input) { double attached?: true }

      before do
        expect(subject).to receive_message_chain(:helpers, :url_for).with(input).
          and_return('https://test.host/input')
      end

      its(:input_url) { should eq 'https://test.host/input' }
    end
  end

  describe '#answer_url' do
    before { allow(subject).to receive(:answer).and_return(answer) }

    context do
      let(:answer) { double attached?: false }

      its(:answer_url) { should be_nil }
    end

    context do
      let(:answer) { double attached?: true }

      before do
        expect(subject).to receive_message_chain(:helpers, :url_for).with(answer).
          and_return('https://test.host/answer')
      end

      its(:answer_url) { should eq 'https://test.host/answer' }
    end
  end
end
