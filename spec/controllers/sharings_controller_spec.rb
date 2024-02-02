require 'rails_helper'

RSpec.describe SharingsController, type: :controller do
  it_behaves_like :create, params: { contest_id: 24 } do
    let(:resource) { double }

    let(:parent) { stub_model Contest }

    before { allow(subject).to receive(:parent).and_return(parent) }

    let(:success) { -> { should redirect_to parent } }

    let(:failure) { -> { should render_template :new } }
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
      before { expect(subject).to receive(:params).and_return(contest_id: 28) }

      before { expect(Contest).to receive(:find).with(28).and_return(:parent) }

      its(:parent) { should eq :parent }
    end
  end

  describe '#resource_params' do
    let(:params) { acp sharing: { problem_id: 57 } }

    before { expect(subject).to receive(:params).and_return(params) }

    before { expect(subject).to receive(:parent).and_return(:parent) }

    its(:resource_params) { should eq params[:sharing].permit!.merge(contest: :parent) }
  end

  describe '#initialize_resource' do
    before { expect(subject).to receive(:parent).and_return(:parent) }

    before { expect(Sharing).to receive(:new).with(contest: :parent).and_return(:resource) }

    before { subject.send :initialize_resource }

    its(:resource) { should eq :resource }
  end

  describe '#build_resource' do
    before { expect(subject).to receive(:resource_params).and_return(:resource_params) }

    before { expect(Sharing).to receive(:new).with(:resource_params).and_return(:resource) }

    before { subject.send :build_resource }

    its(:resource) { should eq :resource }
  end
end
