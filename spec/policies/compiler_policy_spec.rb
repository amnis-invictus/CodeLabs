require 'rails_helper'

RSpec.describe CompilerPolicy do
  subject { described_class }

  fixtures :users

  permissions :index?, :new?, :edit?, :create?, :update? do
    it { should_not permit nil, double }

    it { should_not permit users(:one), double }

    it { should permit users(:two), double }
  end

  permissions :destroy? do
    context do
      let(:resource) { double persisted?: true }

      it { should_not permit nil, resource }

      it { should_not permit users(:one), resource }

      it { should permit users(:two), resource }
    end

    context do
      let(:resource) { double persisted?: false }

      it { should_not permit nil, resource }

      it { should_not permit users(:one), resource }

      it { should_not permit users(:two), resource }
    end
  end
end
