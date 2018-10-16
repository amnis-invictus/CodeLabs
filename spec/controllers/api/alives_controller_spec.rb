require 'rails_helper'

RSpec.describe Api::AlivesController, type: :controller do
  it_behaves_like :create, params: { worker_id: 83 }, format: :json do
    let(:resource) { double }

    let(:success) { -> { should respond_with 204 } }

    let(:failure) { -> { should render_template(:errors).with_status(422) } }
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
      before { expect(subject).to receive(:params).and_return(worker_id: 79) }

      before { expect(Worker).to receive(:find).with(79).and_return(:parent) }

      its(:parent) { should eq :parent }
    end
  end

  describe '#build_resource' do
    before { expect(subject).to receive(:parent).and_return(:parent) }

    before { expect(subject).to receive(:resource_params).and_return(:resource_params) }

    before { expect(Api::Alive).to receive(:new).with(:parent, :resource_params).and_return(:resource) }

    before { subject.send :build_resource }

    its(:resource) { should eq :resource }
  end

  describe '#resource_params' do
    let(:params) { acp alive: { status: 'ok', task_status: ['Working', 'Stopped'] } }

    before { expect(subject).to receive(:params).and_return(params) }

    its(:resource_params) { should eq params[:alive].permit! }
  end
end
