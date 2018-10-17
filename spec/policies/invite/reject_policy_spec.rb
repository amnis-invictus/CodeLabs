require 'rails_helper'

RSpec.describe Invite::RejectPolicy do
  subject { described_class }

  fixtures :users

  let(:resource) { Invite::Accept.new invite }

  permissions :new?, :create? do
    context do
      let(:invite) { stub_model Invite, status: :pending }

      it { should_not permit nil, resource }
    end

    context do
      let(:invite) { stub_model Invite, status: :pending, sender: users(:one), receiver: users(:two) }

      it { should_not permit users(:three), resource }
    end

    context do
      let(:invite) { stub_model Invite, status: :accepted, sender: users(:one), receiver: users(:two) }

      it { should_not permit users(:two), resource }
    end

    context do
      let(:invite) { stub_model Invite, status: :rejected, sender: users(:one), receiver: users(:two) }

      it { should_not permit users(:two), resource }
    end

    context do
      let(:invite) { stub_model Invite, status: :pending, sender: users(:one), receiver: users(:two) }

      it { should permit users(:two), resource }
    end

    context do
      let(:invite) { stub_model Invite, status: :pending, sender: users(:one), receiver: users(:two) }

      it { should permit users(:one), resource }
    end
  end
end
