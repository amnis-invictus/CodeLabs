require 'rails_helper'

RSpec.describe ContestMembershipPolicy do
  subject { described_class }

  fixtures :users, :contests, :memberships

  permissions :destroy? do
    it { should_not permit nil, double }

    it { should_not permit users(:three), memberships(:two) }

    it { should permit users(:one), memberships(:two) }

    it { should permit users(:two), memberships(:two) }
  end

  permissions :create? do
    it { should_not permit nil, double }

    context do
      let(:resource) { stub_model ContestMembership, membershipable: stub_model(Contest), user: stub_model(User) }

      it { should permit double, resource }
    end

    context do
      let(:resource) { stub_model ContestMembership, membershipable: stub_model(Contest), state: :requested }

      it { should permit double, resource }
    end

    context do
      let(:resource) { stub_model ContestMembership, state: :invited, user: stub_model(User) }

      it { should permit double, resource }
    end

    context do
      let(:resource) { stub_model ContestMembership, contest: contests(:one), user: stub_model(User), state: :invited }

      it { should permit users(:one), resource }
    end

    context do
      let(:resource) { stub_model ContestMembership, contest: contests(:one), user: stub_model(User), state: :invited }

      before { resource.contest.visibility = :public }

      it { should permit users(:two), resource }
    end

    context do
      let(:resource) { stub_model ContestMembership, contest: contests(:one), user: stub_model(User), state: :invited }

      before { resource.contest.visibility = :private }

      it { should_not permit users(:two), resource }
    end

    context do
      let(:resource) { stub_model ContestMembership, contest: contests(:one), user: stub_model(User), state: :invited }

      before { resource.contest.visibility = :moderated }

      it { should_not permit users(:two), resource }
    end

    context do
      let(:resource) { stub_model ContestMembership, contest: contests(:one), user: users(:one), state: :requested }

      before { resource.contest.visibility = :moderated }

      it { should permit users(:one), resource }
    end

    context do
      let(:resource) { stub_model ContestMembership, contest: contests(:one), user: users(:one), state: :requested }

      before { resource.contest.visibility = :moderated }

      it { should_not permit users(:two), resource }
    end

    context do
      let(:resource) { stub_model ContestMembership, contest: contests(:one), user: users(:one), state: :requested }

      before { resource.contest.visibility = :private }

      it { should_not permit users(:one), resource }
    end

    context do
      let(:resource) { stub_model ContestMembership, contest: contests(:one), user: users(:one), state: :requested }

      before { resource.contest.visibility = :public }

      it { should_not permit users(:one), resource }
    end

    context do
      let(:resource) { stub_model ContestMembership, contest: contests(:one), user: users(:one), state: :accepted }

      before { resource.contest.visibility = :public }

      it { should permit users(:one), resource }
    end

    context do
      let(:resource) { stub_model ContestMembership, contest: contests(:one), user: users(:one), state: :accepted }

      before { resource.contest.visibility = :public }

      it { should_not permit users(:two), resource }
    end

    context do
      let(:resource) { stub_model ContestMembership, contest: contests(:one), user: users(:one), state: :accepted }

      before { resource.contest.visibility = :private }

      it { should_not permit users(:one), resource }
    end

    context do
      let(:resource) { stub_model ContestMembership, contest: contests(:one), user: users(:one), state: :accepted }

      before { resource.contest.visibility = :moderated }

      it { should_not permit users(:one), resource }
    end
  end

  permissions :update? do
    it { should_not permit nil, double }

    context do
      let(:resource) { stub_model ContestMembership, contest: contests(:one), user: users(:three), state: :requested }

      it { should permit users(:one), resource }
    end

    context do
      let(:resource) { stub_model ContestMembership, contest: contests(:one), user: users(:three), state: :requested }

      it { should_not permit users(:three), resource }
    end

    context do
      let(:resource) { stub_model ContestMembership, contest: contests(:one), user: users(:three), state: :invited }

      it { should permit users(:three), resource }
    end

    context do
      let(:resource) { stub_model ContestMembership, contest: contests(:one), user: users(:three), state: :invited }

      it { should_not permit users(:one), resource }
    end
  end

  describe '#index?' do
    context do
      subject { described_class.new nil, double }

      its(:index?) { should be false }
    end

    context do
      subject { described_class.new users(:one), memberships(:one), parent: contests(:one) }

      its(:index?) { should be true }
    end

    context do
      subject { described_class.new users(:two), memberships(:one), parent: contests(:one) }

      its(:index?) { should be false }
    end

    context do
      subject { described_class.new users(:two), memberships(:one) }

      its(:index?) { should be true }
    end
  end
end
