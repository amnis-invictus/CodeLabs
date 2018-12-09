require 'rails_helper'

RSpec.describe Submission, type: :model do
  it { should belong_to :problem }

  it { should belong_to :user }

  it { should belong_to :compiler }

  pending { should have_one_attached :source }

  it { should have_one(:log).conditions(type: :source) }

  it { should have_many :results }

  it { should have_many :logs }

  it { should define_enum_for(:test_state).with_values(pending: 0, in_progress: 1, done: 2, failed: 3).with_prefix }

  it { should define_enum_for(:test_result).with_values(ok: 0, compiler_error: 1).with_prefix }

  it { should delegate_method(:as_json).to(:decorate) }

  it { should delegate_method(:data).to(:log).with_prefix }

  it { should delegate_method(:user).to(:problem).with_prefix }

  it { should delegate_method(:private?).to(:problem).with_prefix }

  it { should have_state :pending }

  it { should transition_from(:pending).to(:in_progress).on_event(:take) }

  it { should transition_from(:in_progress).to(:done).on_event(:release) }

  describe '#fail' do
    context do
      before { subject.fails_count = 0 }

      it { should transition_from(:in_progress).to(:pending).on_event(:fail) }
    end

    context do
      before { subject.fails_count = 5 }

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
end
