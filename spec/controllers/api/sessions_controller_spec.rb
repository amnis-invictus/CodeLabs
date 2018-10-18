require 'rails_helper'

RSpec.describe Api::SessionsController, type: :controller do
  it_behaves_like :create, params: { worker_id: 83 }, format: :json do
    let(:resource) { double }

    let(:success) { -> { should respond_with 204 } }

    let(:failure) { -> { should render_template(:errors).with_status(422) } }
  end

  it_behaves_like :destroy, params: { worker_id: 83 }, format: :json do
    let(:resource) { double }

    let(:success) { -> { should respond_with 204 } }
  end

  describe '#resource' do
    context do
      before { subject.instance_variable_set :@resource, :resource }

      its(:resource) { should eq :resource }
    end

    context do
      before { expect(subject).to receive(:build_resource).and_return(:resource) }

      its(:resource) { should eq :resource }
    end
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

    before { expect(Api::Worker::Session).to receive(:new).with(:parent).and_return(:resource) }

    before { subject.send :build_resource }

    its(:resource) { should eq :resource }
  end
end
