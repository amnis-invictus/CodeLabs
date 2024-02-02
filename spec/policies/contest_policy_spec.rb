require 'rails_helper'

RSpec.describe ContestPolicy do
  subject { described_class }

  let(:resource) { double }

  let(:user) { stub_model User }

  permissions :index? do
    it { should_not permit nil, resource }

    it { should permit user, resource }
  end

  permissions :new?, :create? do
    it { should_not permit nil, resource }

    it { should_not permit user, resource }

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
      let(:resource) { stub_model Contest, owner: stub_model(User) }

      it { should_not permit user, resource }
    end

    context do
      let(:resource) { stub_model Contest, owner: user }

      it { should permit user, resource }
    end
  end

  permissions :show? do
    it { should_not permit nil, resource }

    context do
      let(:resource) { stub_model Contest, visibility: :private, owner: stub_model(User) }

      before { expect(resource).to receive(:accepted_users).and_return([stub_model(User)]) }

      it { should_not permit user, resource }
    end

    context do
      let(:resource) { stub_model Contest, visibility: :private, owner: stub_model(User) }

      before { expect(resource).to receive(:accepted_users).and_return([stub_model(User), user]) }

      it { should permit user, resource }
    end

    context do
      let(:resource) { stub_model Contest, visibility: :private, owner: user }

      it { should permit user, resource }
    end

    context do
      let(:resource) { stub_model Contest, visibility: :moderated }

      it { should permit user, resource }
    end

    context do
      let(:resource) { stub_model Contest, visibility: :public }

      it { should permit user, resource }
    end
  end

  permissions :new_sharing?, :index_memberships? do
    fixtures :users, :contests

    it { should_not permit nil, resource }

    it { should permit users(:one), contests(:one) }

    it { should_not permit users(:two), contests(:one) }

    it { should_not permit users(:three), contests(:one) }
  end

  permissions :new_invite? do
    fixtures :users, :contests, :memberships

    it { should_not permit nil, resource }

    it { should permit users(:one), contests(:one) }

    context do
      let(:resource) { contests :one }

      before { resource.visibility = :public }

      it { should permit users(:two), contests(:one) }

      it { should_not permit users(:three), contests(:one) }
    end

    context do
      let(:resource) { contests :one }

      before { resource.visibility = :private }

      it { should_not permit users(:two), contests(:one) }

      it { should_not permit users(:three), contests(:one) }
    end

    context do
      let(:resource) { contests :one }

      before { resource.visibility = :moderated }

      it { should_not permit users(:two), contests(:one) }

      it { should_not permit users(:three), contests(:one) }
    end
  end
end
