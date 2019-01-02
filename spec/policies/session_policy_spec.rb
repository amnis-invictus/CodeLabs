require 'rails_helper'

RSpec.describe SessionPolicy do
  subject { described_class }

  fixtures :users

  permissions :new?, :create? do
    it { should permit nil, double }

    it { should_not permit users(:one), double }
  end

  permissions :destroy? do
    it { should permit users(:one), double }

    it { should_not permit nil, double }
  end
end
