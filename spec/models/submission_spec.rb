require 'rails_helper'

RSpec.describe Submission, type: :model do
  it { should belong_to :problem }

  it { should belong_to :user }

  it { should belong_to :compiler }

  it { should have_one :source_attachment }

  it { should have_many(:results).dependent(:destroy) }

  it { should have_many(:logs).dependent(:destroy) }

  it { should define_enum_for(:test_state).with_values(pending: 0, in_progress: 1, done: 2, failed: 3).with_prefix }

  it { should define_enum_for(:test_result).with_values(ok: 0, compiler_error: 1).with_prefix }

  it { should delegate_method(:as_json).to(:decorate) }

  it { should delegate_method(:user).to(:problem).with_prefix }

  it { should delegate_method(:private?).to(:problem).with_prefix }

  it { should callback(:update_standings).after(:commit) }

  it { should have_state :pending }

  it { should transition_from(:pending).to(:in_progress).on_event(:take) }

  it { should transition_from(:in_progress).to(:done).on_event(:release) }

  describe '#fail' do
    before { expect(subject).to receive(:increment!).with(:fails_count) }

    context do
      subject { stub_model described_class, fails_count: 0 }

      before { expect(subject).to receive_message_chain(:results, :delete_all) }

      it { should transition_from(:in_progress).to(:pending).on_event(:fail) }
    end

    context do
      subject { stub_model described_class, fails_count: 5 }

      it { should transition_from(:in_progress).to(:failed).on_event(:fail) }
    end
  end

  describe '#source_must_be_attached' do
    before { allow(subject).to receive(:source).and_return(source) }

    let(:call) { -> { subject.send :source_must_be_attached } }

    context do
      let(:source) { double attached?: true }

      it { expect(&call).to_not change { subject.errors.details } }
    end

    context do
      let(:source) { double attached?: false }

      it { expect(&call).to change { subject.errors.details[:source] }.to [{error: :blank}] }
    end
  end

  describe '#update_standings' do
    subject { stub_model Submission, user_id: 5, problem_id: 12 }

    it { expect(StandingRedisStore).to receive(:update_if_exists).with(5, 12) }

    after { subject.send :update_standings }
  end
end
