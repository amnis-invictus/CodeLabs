require 'rails_helper'

RSpec.describe SubmissionSearcher do
  let(:relation) { Submission.all }

  subject { described_class.search relation, params }

  describe '#search_by_user_id' do
    let(:params) { acp user_id: 7 }

    it { should eq Submission.where(user_id: 7) }
  end

  describe '#search_by_problem_id' do
    let(:params) { acp problem_id: 7 }

    it { should eq Submission.where(problem_id: 7) }
  end

  describe '#search_by_group_id' do
    let(:params) { acp group_id: 7 }

    it { should eq Submission.joins(user: :accepted_memberships).where(memberships: { group_id: 7 }) }
  end
end
