require 'rails_helper'

RSpec.describe Invite::AcceptPolicy do
  subject { described_class }

  fixtures :invites, :users

  let(:resource) { Invite::Accept.new invites :one }

  permissions :new?, :create? do
    it { should_not permit nil, resource }

    it { should_not permit users(:one), resource }

    it { should_not permit users(:three), resource }

    it { should_not permit users(:two), Invite::Accept.new(invites :two) }

    it { should permit users(:two), resource }
  end
end
