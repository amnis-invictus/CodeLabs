require 'rails_helper'

RSpec.describe SharingPolicy do
  subject { described_class }

  fixtures :users

  permissions :new? do
    let(:resource) { stub_model Sharing, contest: stub_model(Contest, owner: users(:one)) }

    it { should permit users(:one), resource }

    it { should_not permit users(:two), resource }

    it { should_not permit users(:three), resource }

    it { should_not permit nil, resource }
  end

  permissions :create? do
    it { should_not permit nil, double }

    let(:resource) { stub_model Sharing, contest: contest, problem: problem }

    context do
      let(:contest) { stub_model Contest, owner: users(:one) }

      let(:problem) { stub_model Problem, user: users(:three) }

      it { should_not permit users(:one), resource }

      it { should_not permit users(:two), resource }

      it { should_not permit users(:three), resource }
    end

    context do
      let(:contest) { stub_model Contest, owner: users(:one) }

      let(:problem) { stub_model Problem, user: users(:one) }

      it { should permit users(:one), resource }

      it { should_not permit users(:two), resource }

      it { should_not permit users(:three), resource }
    end
  end
end
