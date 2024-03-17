require 'rails_helper'

RSpec.describe SubmissionFilter do
  subject { described_class.new defined?(params) ? params : acp }

  it { should delegate_method(:id).to(:contest).with_prefix(true).allow_nil }

  it { should delegate_method(:name).to(:contest).with_prefix(true).allow_nil }

  it { should delegate_method(:id).to(:group).with_prefix(true).allow_nil }

  it { should delegate_method(:name).to(:group).with_prefix(true).allow_nil }

  it { should delegate_method(:id).to(:problem).with_prefix(true).allow_nil }

  it { should delegate_method(:caption).to(:problem).with_prefix(true).allow_nil }

  it { should delegate_method(:id).to(:user).with_prefix(true).allow_nil }

  it { should delegate_method(:name).to(:user).with_prefix(true).allow_nil }

  its(:model_name) { should be_a ActiveModel::Name }

  describe '#submissions' do
    context do
      let(:params) { acp contest_id: 1, group_id: 2, problem_id: 3, user_id: 4 }

      let(:contest) { stub_model Contest }

      let(:group) { stub_model Group }

      let(:problem) { stub_model Problem }

      let(:user) { stub_model User }

      before { expect(Contest).to receive(:find).with(1).and_return(contest) }

      before { expect(Group).to receive(:find).with(2).and_return(group) }

      before { expect(Problem).to receive(:find).with(3).and_return(problem) }

      before { expect(User).to receive(:find).with(4).and_return(user) }

      before do
        expect(SubmissionSearcher).to \
          receive(:search).with(Submission.all, contest:, group:, problem:, user:).and_return(:submissions)
      end

      its(:submissions) { should eq :submissions }
    end

    context do
      let(:params) { acp }

      before { expect(Contest).to_not receive(:find) }

      before { expect(Group).to_not receive(:find) }

      before { expect(Problem).to_not receive(:find) }

      before { expect(User).to_not receive(:find) }

      its(:submissions) { should eq Submission.all }
    end
  end

  describe '#applied?' do
    let(:params) { acp contest_id: 1 }

    it { expect(subject.applied? :contest).to be true }

    it { expect(subject.applied? :group).to be false }
  end
end
