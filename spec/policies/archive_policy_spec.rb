require 'rails_helper'

RSpec.describe ArchivePolicy do
  subject { described_class }

  let(:resource) { double }

  permissions :new?, :create? do
    context do
      let(:user) { stub_model User }

      it { should_not permit user, resource }
    end

    context do
      let(:user) { stub_model User, roles: [:moderator] }

      it { should_not permit user, resource }
    end

    context do
      let(:user) { stub_model User, roles: [:confirmed] }

      it { should_not permit user, resource }
    end

    context do
      let(:user) { stub_model User, roles: [:administrator] }

      it { should permit user, resource }
    end
  end
end
