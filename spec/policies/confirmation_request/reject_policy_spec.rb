require 'rails_helper'

RSpec.describe ConfirmationRequest::RejectPolicy do
  subject { described_class }

  fixtures :users

  let(:resource) { ConfirmationRequest::Reject.new confirmation_request }

  permissions :new?, :create? do
    context do
      let(:confirmation_request) { stub_model ConfirmationRequest, status: :pending }

      it { should_not permit nil, resource }
    end

    context do
      let(:confirmation_request) { stub_model ConfirmationRequest, status: :pending }

      it { should_not permit users(:one), resource }
    end

    context do
      let(:confirmation_request) { stub_model ConfirmationRequest, status: :pending }

      it { should_not permit users(:three), resource }
    end

    context do
      let(:confirmation_request) { stub_model ConfirmationRequest, status: :accepted }

      it { should_not permit users(:two), resource }
    end

    context do
      let(:confirmation_request) { stub_model ConfirmationRequest, status: :rejected }

      it { should_not permit users(:two), resource }
    end

    context do
      let(:confirmation_request) { stub_model ConfirmationRequest, status: :pending }

      it { should permit users(:two), resource }
    end
  end
end
