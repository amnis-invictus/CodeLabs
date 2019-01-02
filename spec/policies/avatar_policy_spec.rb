require 'rails_helper'

RSpec.describe AvatarPolicy do
  subject { described_class }

  fixtures :users

  let(:resource) { Avatar.new user: users(:one) }

  permissions :create?, :destroy? do
    it { should permit users(:one), resource }

    it { should_not permit nil, resource }

    it { should_not permit users(:two), resource }
  end
end
