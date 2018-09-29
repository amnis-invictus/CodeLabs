require 'rails_helper'

RSpec.describe ProblemDecorator do
  let(:translation) { stub_model ProblemTranslation, language: 'ru' }

  let(:default_translation) { stub_model ProblemTranslation, language: 'uk', default: true }

  let(:resource) { stub_model Problem, id: 24, updated_at: Date.today, checker_compiler_id: 1 }

  before { allow(resource).to receive(:translation).and_return(translation) }

  before { allow(resource).to receive(:default_translation).and_return(default_translation) }

  subject { resource.decorate }

  it { should delegate_method(:caption).to(:translation) }

  it { should delegate_method(:author).to(:translation) }

  it { should delegate_method(:text).to(:translation) }

  it { should delegate_method(:technical_text).to(:translation) }

  describe '#as_json' do
    context do
      before { expect(subject).to receive(:checker_source_url).and_return(:checker_source_url) }

      before { expect(subject).to receive(:tests).and_return(:tests) }

      its :as_json do
        should eq id: 24, updated_at: Date.today, checker_compiler_id: 1,
          checker_source_url: :checker_source_url, tests: :tests
      end
    end

    context do
      subject { resource.decorate context: :submission }

      its(:as_json) { should eq id: 24, updated_at: Date.today, checker_compiler_id: 1 }
    end
  end

  describe '#checker_source_url' do
    before { allow(subject).to receive(:checker_source).and_return(checker_source) }

    context do
      let(:checker_source) { double attached?: false }

      its(:checker_source_url) { should be_nil }
    end

    context do
      let(:checker_source) { double attached?: true }

      before do
        expect(subject).to receive_message_chain(:helpers, :url_for).with(checker_source).
          and_return('https://test.host/checker_source')
      end

      its(:checker_source_url) { should eq 'https://test.host/checker_source' }
    end
  end

  describe '#translation' do
    its(:translation) { should eq translation }

    context do
      let(:translation) { nil }

      its(:translation) { should eq default_translation }
    end
  end

  describe '#language' do
    its(:language) { should eq :ru }

    context do
      let(:translation) { nil }

      let(:default_translation) { nil }

      its(:language) { should be_nil }
    end
  end
end
