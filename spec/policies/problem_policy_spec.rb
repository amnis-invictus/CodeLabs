require 'rails_helper'

RSpec.describe ProblemPolicy do
  subject { described_class }

  permissions :new?, :create? do
    let(:resource) { double }

    it { should_not permit nil, resource }

    context do
      let(:user) { stub_model User, roles: [] }

      it { should_not permit user, resource }
    end

    context do
      let(:user) { stub_model User, roles: [:administrator] }

      it { should_not permit user, resource }
    end

    context do
      let(:user) { stub_model User, roles: [:moderator] }

      it { should_not permit user, resource }
    end

    context do
      let(:user) { stub_model User, roles: [:confirmed] }

      it { should permit user, resource }
    end
  end

  permissions :edit?, :update?, :destroy? do
    let(:owner) { stub_model User }

    let(:resource) { double user: owner }

    it { should_not permit nil, resource }

    context do
      let(:user) { stub_model User, roles: [:confirmed] }

      it { should_not permit user, resource }
    end

    context do
      let(:user) { stub_model User, roles: [:administrator] }

      it { should_not permit user, resource }
    end

    context do
      let(:user) { stub_model User, roles: [:moderator] }

      it { should permit user, resource }
    end

    it { should permit owner, resource }
  end

  permissions :index? do
    it { should permit nil, double }
  end

  permissions :show? do
    context do
      let(:resource) { stub_model Problem, private: false }

      it { should permit nil, resource }

      it { should permit stub_model(User), resource }
    end

    context do
      let(:owner) { stub_model User }

      let(:resource) { stub_model Problem, private: true, user: owner }

      it { should permit owner, resource }

      context do
        let(:user) { stub_model User, roles: [:moderator] }

        it { should permit user, resource }
      end

      context do
        let(:user) { stub_model User }

        before { expect(user).to receive(:shared_problems).and_return([resource]) }

        it { should permit user, resource }
      end

      context do
        let(:user) { stub_model User }

        before { expect(user).to receive(:shared_problems).and_return([]) }

        it { should_not permit user, resource }
      end

      context do
        let(:user) { stub_model User, roles: [:administrator] }

        before { expect(user).to receive(:shared_problems).and_return([]) }

        it { should_not permit user, resource }
      end

      context do
        let(:user) { stub_model User, roles: [:confirmed] }

        before { expect(user).to receive(:shared_problems).and_return([]) }

        it { should_not permit user, resource }
      end
    end
  end
end
