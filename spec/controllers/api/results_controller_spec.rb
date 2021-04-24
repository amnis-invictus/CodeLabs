require 'rails_helper'

RSpec.describe Api::ResultsController, type: :controller do
  it { should be_an Api::ApplicationController }

  it_behaves_like :create, format: :json do
    let(:resource) { double }

    let(:success) { -> { should respond_with 204 } }

    let(:failure) { -> { should render_template(:errors).with_status(422) } }
  end

  describe '#resource' do
    before { subject.instance_variable_set :@resource, :resource }

    its(:resource) { should eq :resource }
  end

  describe '#resource_params' do
    let :params do
      acp result: {
        status: 6,
        log: 'Number is correct',
        memory: 109.42,
        time: 98.24,
        test_id: 12,
        submission_id: 5,
      }
    end

    before { expect(subject).to receive(:params).and_return(params) }

    its(:resource_params) { should eq params[:result].permit! }
  end

  describe '#build_resource' do
    before { expect(subject).to receive(:resource_params).and_return(:resource_params) }

    before { expect(Result).to receive(:new).with(:resource_params).and_return(:resource) }

    before { subject.send :build_resource }

    its(:resource) { should eq :resource }
  end
end
