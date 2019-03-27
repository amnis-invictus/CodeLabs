require 'rails_helper'

RSpec.describe SubmissionDecorator do
  let :problem do
    stub_model Problem, id: 24, updated_at: Date.today, checker_compiler_id: 1, memory_limit: 256, time_limit: 100
  end

  let(:compiler) { stub_model Compiler, memory_a: 12.28, memory_b: 5.112, time_a: 143, time_b: 3.14 }

  let(:resource) { stub_model Submission, id: 125, compiler_id: 3, test_state: 0, fails_count: 2 }

  before { allow(resource).to receive(:problem).and_return(problem) }

  before { allow(resource).to receive(:compiler).and_return(compiler) }

  subject { resource.decorate }

  it { should delegate_method(:username).to(:user).with_prefix }

  it { should delegate_method(:caption).to(:problem).with_prefix }

  its(:memory_limit) { should eq 3148.792 }

  its(:time_limit) { should eq 14303.14 }

  describe '#as_json' do
    before { expect(subject).to receive(:source_url).and_return(:source_url) }

    its :as_json do
      should eq id: 125, compiler_id: 3, problem: problem, source_url: :source_url, test_state: 0,
        fails_count: 2, memory_limit: 3148.792, time_limit: 14303.14
    end
  end

  describe '#source_url' do
    before { allow(subject).to receive(:source).and_return(source) }

    context do
      let(:source) { double attached?: false }

      its(:source_url) { should be_nil }
    end

    context do
      let(:source) { double attached?: true }

      before do
        expect(subject).to receive_message_chain(:helpers, :url_for).with(source).
          and_return('https://test.host/source')
      end

      its(:source_url) { should eq 'https://test.host/source' }
    end
  end

  describe '#state' do
    let(:resource) { stub_model Submission, test_state: test_state, test_result: test_result, score: 60, max_score: 100 }

    context do
      let(:test_state) { :done }

      let(:test_result) { :ok }

      its(:state) { should eq 'Ok (60.0/100.0)' }
    end

    context do
      let(:test_state) { :done }

      let(:test_result) { :compiler_error }

      its(:state) { should eq 'Compiler error' }
    end

    context do
      let(:test_state) { :in_progress }

      let(:test_result) { nil }

      its(:state) { should eq 'In progress' }
    end
  end
end
