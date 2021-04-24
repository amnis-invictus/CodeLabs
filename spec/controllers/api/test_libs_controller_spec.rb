require 'rails_helper'

RSpec.describe Api::TestLibsController, type: :controller do
  it { should be_an Api::ApplicationController }

  it_behaves_like :create, format: :json, unauthorized: true do
    let(:resource) { double }

    let(:success) { -> { should respond_with 204 } }

    let(:failure) { -> { should render_template(:errors).with_status(422) } }
  end

  it_behaves_like :show, format: :json, unauthorized: true, anonymous: true, params: { version: 'latest' }

  pending { should route(:post, '/api/test_libs').to(action: :create) }

  it { should route(:get, '/api/test_libs/1.0.7784.34987').to(action: :show, version: '1.0.7784.34987') }

  it { should route(:get, '/api/test_libs/latest').to(action: :show, version: 'latest') }

  describe '#resource' do
    context do
      before { subject.instance_variable_set :@resource, :resource }

      its(:resource) { should eq :resource }
    end

    context do
      before { allow(subject).to receive(:params).and_return(version: '1.0.7784.34987') }

      before { expect(TestLib).to receive(:find_by).with(version: [1, 0, 7_784, 34_987]).and_return(:resource) }

      its(:resource) { should eq :resource }
    end

    context do
      before { allow(subject).to receive(:params).and_return(version: 'latest') }

      before do
        #
        # TestLib.order(version: :desc).first -> :resource
        #
        expect(TestLib).to receive(:order).with(version: :desc) do
          double.tap { expect(_1).to receive(:first).and_return(:resource) }
        end
      end

      its(:resource) { should eq :resource }
    end
  end

  describe '#resource_params' do
    let(:params) { acp test_lib: { version: '1.0.7784.34987', binary: '' } }

    before { expect(subject).to receive(:params).and_return(params) }

    its(:resource_params) { should eq params[:test_lib].permit! }
  end

  describe '#build_resource' do
    context do
      before { expect(subject).to receive(:resource_params).and_return(version: '1.0.7784.34987', binary: '') }

      before { expect(TestLib).to receive(:new).with(version: [1, 0, 7_784, 34_987], binary: '').and_return(:resource) }

      before { subject.send :build_resource }

      its(:resource) { should eq :resource }
    end

    context do
      before { expect(subject).to receive(:resource_params).and_return({}) }

      before { expect(TestLib).to receive(:new).with(version: [], binary: nil).and_return(:resource) }

      before { subject.send :build_resource }

      its(:resource) { should eq :resource }
    end
  end
end
