require 'rails_helper'

RSpec.describe SubmissionPolicy do
  subject { described_class }

  permissions :index? do
    it { should permit nil, double }
  end

  permissions :show? do
    it { should_not permit nil, double }

    context do
      let(:resource) { stub_model Submission, problem: stub_model(Problem) }
      
      it { should_not permit stub_model(User), resource }
    end

    context do
      let(:user) { stub_model User, roles: [:administrator] }

      let(:resource) { stub_model Submission }

      it { should permit user, resource }
    end

    context do
      let(:user) { stub_model User }

      let(:resource) { stub_model Submission, user: user }

      it { should permit user, resource }
    end

    context do
      let(:user) { stub_model User }

      let(:resource) { stub_model Submission, problem: stub_model(Problem, user: user) }

      it { should permit user, resource }
    end
  end

  permissions :create? do
    it { should_not permit nil, double }

    let(:resource) { stub_model Submission, problem: problem }

    context do
      let(:problem) { stub_model Problem, private: false }

      it { should permit double, resource }
    end

    context do
      let(:problem) { stub_model Problem, private: true }

      let(:user) { stub_model User, roles: [:moderator] }

      it { should permit user, resource }
    end

    context do
      let(:user) { stub_model User }

      let(:problem) { stub_model Problem, private: true, user: user }

      it { should permit user, resource }
    end

    context do
      let(:problem) { stub_model Problem, private: true }

      let(:user) { stub_model User }

      before { expect(user).to receive(:shared_problems).and_return([problem]) }

      it { should permit user, resource }
    end

    context do
      let(:problem) { stub_model Problem, private: true }

      let(:user) { stub_model User }

      before { expect(user).to receive(:shared_problems).and_return([]) }

      it { should_not permit user, resource }
    end
  end
end
