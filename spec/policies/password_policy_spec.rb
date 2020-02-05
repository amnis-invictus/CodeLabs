require 'rails_helper'

RSpec.describe PasswordPolicy do
  subject { described_class }

  fixtures :users

  permissions :edit?, :update? do
    it { should permit nil, double }

    it { should_not permit nil, nil }

    it { should_not permit users(:one), nil }

    it { should_not permit users(:one), double }
  end
end
