require 'rails_helper'

RSpec.describe MembershipDecorator do
  let(:resource) { stub_model Membership, user: stub_model(User), membershipable: stub_model(Contest) }

  subject { resource.decorate }

  its(:user) { should be_a UserDecorator }

  its(:membershipable) { should be_a ContestDecorator }

  it { should delegate_method(:name).to(:user).with_prefix.allow_nil }

  it { should delegate_method(:name).to(:membershipable).with_prefix.allow_nil }
end
