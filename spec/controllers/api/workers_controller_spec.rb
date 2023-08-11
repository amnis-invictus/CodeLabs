require 'rails_helper'

RSpec.describe Api::WorkersController, type: :controller do
  it { should be_an Api::ApplicationController }

  it_behaves_like :create, format: :json do
    let(:resource) { double }

    let(:success) { -> { should render_template(:create).with_status(201) } }

    let(:failure) { -> { should render_template(:errors).with_status(422) } }
  end

  it_behaves_like :update, format: :json do
    let(:resource) { double }

    let(:success) { -> { should respond_with 204 } }

    let(:failure) { -> { should render_template(:errors).with_status(422) } }
  end

  describe '#resource' do
    context do
      before { subject.instance_variable_set :@resource, :resource }

      its(:resource) { should eq :resource }
    end

    context do
      before { expect(subject).to receive(:params).and_return(id: 324) }

      before { expect(Worker).to receive(:find).with(324).and_return(:resource) }

      its(:resource) { should eq :resource }
    end
  end

  describe '#resource_params' do
    let :params do
      acp worker: {
        alive_at: Time.zone.today,
        api_type: 0,
        api_version: 1,
        version: '1.1.0.2',
        name: 'First Worker',
        status: 1,
        webhook_supported: false,
        ips: ['127.0.0.1', '192.168.0.1'],
        task_status: ['Slot 1: Running', 'Slot 2: Stopped'],
      }
    end

    before { expect(subject).to receive(:params).and_return(params) }

    its(:resource_params) { should eq params[:worker].permit! }
  end

  describe '#build_resource' do
    before { expect(subject).to receive(:resource_params).and_return(:resource_params) }

    before { expect(Worker).to receive(:new).with(:resource_params).and_return(:resource) }

    before { subject.send :build_resource }

    its(:resource) { should eq :resource }
  end
end
