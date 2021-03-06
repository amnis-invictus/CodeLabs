require 'rails_helper'

RSpec.describe ConfirmationRequest::RejectsController, type: :controller do
  it_behaves_like :create, params: { confirmation_request_id: 10 } do
    let(:resource) { double }

    let(:success) { -> { should redirect_to :confirmation_requests } }

    let :failure do
      lambda do
        should set_flash[:error]

        should redirect_to :confirmation_requests
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
      before { expect(subject).to receive(:params).and_return(confirmation_request_id: 89) }

      before { expect(ConfirmationRequest).to receive(:find).with(89).and_return(:parent) }

      its(:parent) { should eq :parent }
    end
  end

  describe '#build_resource' do
    before { expect(subject).to receive(:parent).and_return(:parent) }

    before { expect(ConfirmationRequest::Reject).to receive(:new).with(:parent).and_return(:resource) }

    before { subject.send :build_resource }

    its(:resource) { should eq :resource }
  end
end
