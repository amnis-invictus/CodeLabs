require 'rails_helper'

RSpec.describe ConfirmationRequestsController, type: :controller do
  it_behaves_like :create do
    let(:resource) { double }

    let :success do
      lambda do
        should set_flash[:success]

        should redirect_to :profile
      end
    end

    let :failure do
      lambda do
        should set_flash[:error]

        should redirect_to :profile
      end
    end
  end

  describe '#resource' do
    before { subject.instance_variable_set :@resource, :resource }

    its(:resource) { should eq :resource }
  end

  describe '#collection' do
    context do
      before { subject.instance_variable_set :@collection, :collection }

      its(:collection) { should eq :collection }
    end

    context do
      before { expect(subject).to receive(:params).and_return(page: 23) }

      before { expect(ConfirmationRequest).to receive(:page).with(23).and_return(:collection) }

      its(:collection) { should eq :collection }
    end
  end

  describe '#build_resource' do
    before { expect(subject).to receive(:current_user).and_return(:current_user) }

    before { expect(ConfirmationRequest).to receive(:new).with(user: :current_user).and_return(:resource) }

    before  { subject.send :build_resource }

    its(:resource) { should eq :resource }
  end
end
