require 'rails_helper'

RSpec.describe ConfirmationRequest::RejectPolicy do
  subject { described_class }

  let(:sender) { stub_model User }

  let(:status) { :pending }

  let(:confirmation_request) { stub_model ConfirmationRequest, status: status, user: sender }

  let(:resource) { ConfirmationRequest::Accept.new confirmation_request }

  permissions :new?, :create? do
    it { should_not permit nil, resource }

    it { should_not permit sender, resource }

    it { should_not permit stub_model(User), resource }

    context do
      let(:user) { stub_model User, roles: [:administrator] }

      it { should_not permit user, resource }
    end

    context do
      let(:user) { stub_model User, roles: [:confirmed] }

      it { should_not permit user, resource }
    end

    context do
      let(:status) { :accepted }

      let(:user) { stub_model User, roles: [:moderator] }

      it { should_not permit user, resource }
    end

    context do
      let(:status) { :rejected }

      let(:user) { stub_model User, roles: [:moderator] }

      it { should_not permit user, resource }
    end

    context do
      let(:user) { stub_model User, roles: [:moderator] }

      it { should permit user, resource }
    end
  end
end
