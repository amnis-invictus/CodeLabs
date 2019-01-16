require 'rails_helper'

RSpec.describe Api::Submission::ReleaseController, type: :controller do
  it { should be_an Api::ApplicationController }

  it_behaves_like :create, params: { submission_id: 93 }, unauthorized: true, format: :json do
    let(:resource) { double }

    let(:success) { -> { should respond_with 204 } }

    let(:failure) { -> { should respond_with 422 } }
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
      before { expect(subject).to receive(:params).and_return(submission_id: 79) }

      before { expect(Submission).to receive(:find).with(79).and_return(:parent) }

      its(:parent) { should eq :parent }
    end
  end

  describe '#resource_params' do
    let(:params) { acp release: { test_result: 0 } }

    before { expect(subject).to receive(:params).and_return(params) }

    its(:resource_params) { should eq params[:release].permit! }
  end

  describe '#build_resource' do
    before { expect(subject).to receive(:resource_params).and_return(:resource_params) }

    before { expect(subject).to receive(:parent).and_return(:parent) }

    before { expect(Release).to receive(:new).with(:parent, :resource_params).and_return(:resource) }

    before { subject.send :build_resource }

    its(:resource) { should eq :resource }
  end
end
