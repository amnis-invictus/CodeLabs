require 'rails_helper'

RSpec.describe MembershipDecorator do
  let(:resource) { stub_model Membership, user: stub_model(User) }

  subject { resource.decorate }

  its(:user) { should be_a UserDecorator }

  it { should delegate_method(:name).to(:user).with_prefix.allow_nil }
end
