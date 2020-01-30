require 'rails_helper'

RSpec.describe PasswordRecoveryPolicy do
  subject { described_class }

  fixtures :users

  permissions :new?, :create? do
    it { should permit nil, double }

    it { should_not permit users(:one), double }
  end
end
