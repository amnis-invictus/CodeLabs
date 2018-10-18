require 'rails_helper'

RSpec.describe InvitePolicy do
  subject { described_class }

  permissions :index?, :new?, :create? do
    let(:resource) { double }

    let(:user) { nil }

    it { should_not permit user, resource }
  end

  permissions :index? do
    let(:resource) { double }

    let(:user) { double }

    it { should permit user, resource }
  end

  permissions :new?, :create? do
    let(:user) { double }

    context do
      let(:resource) { double group_visibility: 'public' }

      it { should permit user, resource }
    end

    context do
      let(:resource) { double group_visibility: 'private', group_owner: double }

      it { should_not permit user, resource }
    end

    context do
      let(:resource) { double group_visibility: 'private', group_owner: user }

      it { should permit user, resource }
    end

    context do
      let(:resource) { double group_visibility: 'moderated', group_owner: double }

      it { should_not permit user, resource }
    end

    context do
      let(:resource) { double group_visibility: 'moderated', group_owner: user }

      it { should permit user, resource }
    end
  end
end
