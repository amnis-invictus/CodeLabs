require 'rails_helper'

RSpec.describe MembershipDecorator do
  let(:resource) { stub_model Membership, user: stub_model(User), group: stub_model(Group) }

  subject { resource.decorate }

  its(:user) { should be_a UserDecorator }

  its(:group) { should be_a GroupDecorator }

  it { should delegate_method(:name).to(:user).with_prefix.allow_nil }

  it { should delegate_method(:name).to(:group).with_prefix.allow_nil }
end
