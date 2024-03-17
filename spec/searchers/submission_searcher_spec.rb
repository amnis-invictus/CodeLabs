require 'rails_helper'

RSpec.describe SubmissionSearcher do
  let(:relation) { Submission.all }

  subject { described_class.search relation, params }

  describe '#search_by_user_id' do
    let(:params) { acpp user_id: 7 }

    it { should eq Submission.where(user_id: 7) }
  end

  describe '#search_by_problem_id' do
    let(:params) { acpp problem_id: 7 }

    it { should eq Submission.where(problem_id: 7) }
  end

  describe '#search_by_contest_id' do
    let(:params) { acpp contest_id: 7 }

    it do
      should eq Submission.joins(user: :accepted_memberships).where(memberships: { membershipable_id: 7,
                                                                                   membershipable_type: 'Contest' })
    end
  end
end
