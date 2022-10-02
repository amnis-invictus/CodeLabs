require 'rails_helper'

RSpec.describe ConfirmationRequestPolicy do
  subject { described_class }

  fixtures :users, :confirmation_requests

  permissions :new?, :create? do
    let(:resource) { ConfirmationRequest.new user: user }

    context do
      let(:user) { nil }

      it { should_not permit user, resource }
    end

    context do
      let(:user) { users :one }

      it { should_not permit user, resource }
    end

    context do
      let(:user) { users :two }

      it { should_not permit user, resource }
    end

    context do
      let(:user) { users :three }

      it { should permit user, resource }
    end
  end

  permissions :index? do
    it { should_not permit nil, double }

    it { should_not permit users(:one), double }

    it { should_not permit users(:three), double }

    it { should permit users(:two), double }
  end
end
