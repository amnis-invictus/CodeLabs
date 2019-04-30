require 'rails_helper'

RSpec.describe GroupPolicy do
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
      let(:resource) { stub_model Group, owner: stub_model(User) }

      it { should_not permit user, resource }
    end

    context do
      let(:resource) { stub_model Group, owner: user }

      it { should permit user, resource }
    end
  end

  permissions :show? do
    it { should_not permit nil, resource }

    context do
      let(:resource) { stub_model Group, visibility: :private, owner: stub_model(User) }

      before { expect(resource).to receive(:accepted_users).and_return([stub_model(User)]) }

      it { should_not permit user, resource }
    end

    context do
      let(:resource) { stub_model Group, visibility: :private, owner: stub_model(User) }

      before { expect(resource).to receive(:accepted_users).and_return([stub_model(User), user]) }

      it { should permit user, resource }
    end

    context do
      let(:resource) { stub_model Group, visibility: :private, owner: user }

      it { should permit user, resource }
    end

    context do
      let(:resource) { stub_model Group, visibility: :moderated }

      it { should permit user, resource }
    end

    context do
      let(:resource) { stub_model Group, visibility: :public }

      it { should permit user, resource }
    end
  end

  permissions :new_sharing?, :index_memberships? do
    fixtures :users, :groups

    it { should_not permit nil, resource }

    it { should permit users(:one), groups(:one) }

    it { should_not permit users(:two), groups(:one) }

    it { should_not permit users(:three), groups(:one) }
  end

  permissions :new_invite? do
    fixtures :users, :groups, :memberships

    it { should_not permit nil, resource }

    it { should permit users(:one), groups(:one) }

    context do
      let(:resource) { groups :one }

      before { resource.visibility = :public }

      it { should permit users(:two), groups(:one) }

      it { should_not permit users(:three), groups(:one) }
    end

    context do
      let(:resource) { groups :one }

      before { resource.visibility = :private }

      it { should_not permit users(:two), groups(:one) }

      it { should_not permit users(:three), groups(:one) }
    end

    context do
      let(:resource) { groups :one }

      before { resource.visibility = :moderated }

      it { should_not permit users(:two), groups(:one) }

      it { should_not permit users(:three), groups(:one) }
    end
  end
end
