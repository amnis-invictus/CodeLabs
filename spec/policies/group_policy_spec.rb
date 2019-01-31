require 'rails_helper'

RSpec.describe GroupPolicy do
  subject { described_class }

  let(:resource) { double }

  permissions :index? do
    context do
      let(:user) { nil }

      it { should_not permit user, resource }
    end

    context do
      let(:user) { stub_model User }

      it { should permit user, resource }
    end
  end

  permissions :new?, :create? do
    context do
      let(:user) { nil }

      it { should_not permit user, resource }
    end

    context do
      let(:user) { stub_model User }

      it { should_not permit user, resource }
    end

    context do
      let(:user) { stub_model User, roles: [:confirmed] }

      it { should permit user, resource }
    end
  end

  permissions :edit?, :update?, :destroy? do
    context do
      let(:user) { nil }

      it { should_not permit user, resource }
    end

    context do
      let(:user) { stub_model User }

      let(:resource) { stub_model Group, owner: stub_model(User) }

      it { should_not permit user, resource }
    end

    context do
      let(:user) { stub_model User }

      let(:resource) { stub_model Group, owner: user }

      it { should permit user, resource }
    end
  end

  permissions :show? do
    context do
      let(:user) { nil }

      it { should_not permit user, resource }
    end

    context do
      let(:user) { stub_model User }

      let(:resource) { stub_model Group, owner: stub_model(User) }

      before { expect(resource).to receive(:users).and_return([stub_model(User)]) }

      it { should_not permit user, resource }
    end

    context do
      let(:user) { stub_model User }

      let(:resource) { stub_model Group, owner: stub_model(User) }

      before { expect(resource).to receive(:users).and_return([stub_model(User), user]) }

      it { should permit user, resource }
    end

    context do
      let(:user) { stub_model User }

      let(:resource) { stub_model Group, owner: user }

      it { should permit user, resource }
    end
  end
end
