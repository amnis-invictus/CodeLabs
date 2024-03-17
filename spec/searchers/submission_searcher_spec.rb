require 'rails_helper'

RSpec.describe SubmissionSearcher do
  let(:relation) { Submission.all }

  let(:user) { stub_model User }

  let(:problem) { stub_model Problem }

  let(:contest) { stub_model Contest }

  let(:group) { stub_model Group }

  subject { described_class.search relation, params }

  describe '#search_by_user' do
    let(:params) { acpp user: }

    it { should eq Submission.where(user:) }
  end

  describe '#search_by_problem' do
    let(:params) { acpp problem: }

    it { should eq Submission.where(problem:) }
  end

  describe '#search_by_contest' do
    let(:params) { acpp contest: }

    it { should eq Submission.joins(user: :accepted_memberships).where(memberships: { membershipable: contest }) }
  end

  describe '#search_by_group' do
    let(:params) { acpp group: }

    it { should eq Submission.joins(user: :accepted_memberships).where(memberships: { membershipable: group }) }
  end
end
