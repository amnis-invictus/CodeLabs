require 'rails_helper'

RSpec.describe LogPolicy do
  subject { described_class }

  fixtures :users

  permissions :create? do
    let(:resource) { stub_model Log, submission: stub_model(Submission, test_state: test_state) }

    context do
      let(:test_state) { :pending }

      it { should_not permit nil, resource  }
    end

    context do
      let(:test_state) { :in_progress }

      it { should permit nil, resource  }
    end

    context do
      let(:test_state) { :done }

      it { should_not permit nil, resource  }
    end

    context do
      let(:test_state) { :failed }

      it { should_not permit nil, resource  }
    end
  end

  permissions :show? do
    it { should_not permit nil, double }

    it { should permit users(:two), double }

    let(:resource) { stub_model Log, type: :source, submission: submission }

    context do
      let(:submission) { stub_model Submission, user: users(:one) }

      it { should permit users(:one), resource }
    end

    context do
      let(:submission) { stub_model Submission, user: users(:two), problem: stub_model(Problem, user: users(:one)) }

      it { should permit users(:one), resource }
    end

    context do
      let(:submission) { stub_model Submission, user: users(:two), problem: stub_model(Problem, user: users(:three)) }

      it { should_not permit users(:one), resource }
    end
  end
end
