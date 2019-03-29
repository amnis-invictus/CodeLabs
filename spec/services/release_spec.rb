require 'rails_helper'

RSpec.describe Release do
  let(:problem) { stub_model Problem, id: 22 }

  let(:submission) { stub_model Submission, problem: problem }

  subject { described_class.new submission, test_result: :ok }

  describe '#score' do
    before do
      #
      # submission.results.joins(:test).where(status: :ok).sum('tests.point') -> :score
      #
      expect(submission).to receive_message_chain(:results, :joins).with(:test) do
        double.tap do |a|
          expect(a).to receive(:where).with(status: :ok) do
            double.tap { |b| expect(b).to receive(:sum).with('tests.point').and_return(:score) }
          end
        end
      end
    end

    its(:score) { should eq :score }
  end

  describe '#max_score' do
    before do
      #
      # Test.unscoped.where(problem_id: @submission.problem_id).sum(:point) -> :max_score
      #
      expect(Test).to receive_message_chain(:unscoped, :where).with(problem_id: 22) do
        double.tap { |a| expect(a).to receive(:sum).with(:point).and_return(:max_score) }
      end
    end

    its(:max_score) { should eq :max_score }
  end

  describe '#save' do
    context do
      before { expect(submission).to receive(:release).and_return(false) }

      before { expect(submission).to_not receive(:update) }

      its(:save) { should be false }
    end

    context do
      before { expect(submission).to receive(:release).and_return(true) }

      before { expect(subject).to receive(:score).and_return(:score) }

      before { expect(subject).to receive(:max_score).and_return(:max_score) }

      before do
        expect(submission).to \
          receive(:update).with(test_result: :ok, score: :score, max_score: :max_score).and_return(:result)
      end

      its(:save) { should eq :result }
    end
  end
end
