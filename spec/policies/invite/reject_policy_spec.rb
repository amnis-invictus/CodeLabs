require 'rails_helper'

RSpec.describe Invite::RejectPolicy do
  subject { described_class }

  let(:sender) { stub_model User }

  let(:receiver) { stub_model User }

  let(:status) { :pending }

  let(:invite) { stub_model Invite, status: status, sender: sender, receiver: receiver }

  let(:resource) { Invite::Reject.new invite }

  permissions :new?, :create? do
    it { should_not permit nil, resource }

    it { should_not permit stub_model(User), resource }

    it { should permit receiver, resource }

    it { should permit sender, resource }

    context do
      let(:status) { :accepted }

      it { should_not permit receiver, resource }
    end

    context do
      let(:status) { :rejected }

      it { should_not permit receiver, resource }
    end
  end
end
