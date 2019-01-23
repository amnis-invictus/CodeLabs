require 'rails_helper'

RSpec.describe WorkerPolicy do
  subject { described_class }

  fixtures :users

  permissions :create?, :update? do
    it { should permit nil, double }
  end

  permissions :index?, :destroy? do
    it { should_not permit users(:one), double }

    it { should permit users(:two), double }
  end
end
