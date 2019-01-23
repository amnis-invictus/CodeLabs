require 'rails_helper'

RSpec.describe ResultPolicy do
  subject { described_class }

  permissions :create? do
    let(:resource) { stub_model Result, submission: stub_model(Submission, test_state: test_state) }

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
end
