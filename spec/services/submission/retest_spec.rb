require 'rails_helper'

RSpec.describe Submission::Retest do
  let(:submission) { stub_model Submission }

  subject { described_class.new submission }

  its(:submission) { should eq submission }

  describe '#save' do
    before { expect(Submission).to receive(:transaction).and_yield }

    before { expect(submission).to receive_message_chain(:results, :delete_all) }

    before { expect(submission).to receive_message_chain(:logs, :delete_all) }

    before do
      expect(submission).to receive(:update).
        with(test_state: :pending, fails_count: 0, score: nil, test_result: nil, max_score: nil).and_return(:result)
    end

    its(:save) { should eq :result }
  end
end
