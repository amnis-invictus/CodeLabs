require 'rails_helper'

RSpec.describe Submission::RetestsController, type: :controller do
  it_behaves_like :create, params: { submission_id: 2 } do
    let(:resource) { double }

    let(:parent) { stub_model Submission }

    before { allow(subject).to receive(:parent).and_return(parent) }

    let(:success) { -> { should redirect_to parent } }

    let :failure do
      lambda do
        should set_flash[:error]

        should redirect_to parent
      end
    end
  end

  describe '#resource' do
    before { subject.instance_variable_set :@resource, :resource }

    its(:resource) { should eq :resource }
  end

  describe '#parent' do
    context do
      before { subject.instance_variable_set :@parent, :parent }

      its(:parent) { should eq :parent }
    end

    context do
      before { expect(subject).to receive(:params).and_return(submission_id: 3) }

      before { expect(Submission).to receive(:find).with(3).and_return(:parent) }

      its(:parent) { should eq :parent }
    end
  end

  describe '#build_resource' do
    before { expect(subject).to receive(:parent).and_return(:parent) }

    before { expect(Submission::Retest).to receive(:new).with(:parent).and_return(:resource) }

    before { subject.send :build_resource }

    its(:resource) { should eq :resource }
  end
end
