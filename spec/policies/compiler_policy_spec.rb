require 'rails_helper'

RSpec.describe CompilerPolicy do
  subject { described_class }

  fixtures :users

  permissions :index?, :new?, :edit?, :create?, :update?, :destroy? do
    it { should_not permit nil, double }

    it { should_not permit users(:one), double }

    it { should permit users(:two), double }
  end
end
