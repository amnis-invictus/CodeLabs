require 'rails_helper'

RSpec.describe UserPolicy do
  subject { described_class }

  fixtures :users

  let(:resource) { users :one }

  permissions :index? do
    it { should permit nil, resource }

    it { should permit double, resource }
  end

  permissions :new?, :create? do
    it { should permit nil, resource }

    it { should_not permit double, resource }
  end

  permissions :show?, :edit?, :update? do
    it { should_not permit nil, resource }

    it { should_not permit users(:two), resource }

    it { should permit users(:one), resource }
  end
end
