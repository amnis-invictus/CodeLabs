require 'rails_helper'

RSpec.describe Invite::RejectsController, type: :controller do
  it_behaves_like :create, params: { invite_id: 10 } do
    let(:resource) { double }

    let(:success) { -> { should redirect_to :received_invites } }

    let :failure do
      lambda do
        should set_flash[:error]

        should redirect_to :received_invites
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
      before { expect(subject).to receive(:params).and_return(invite_id: 89) }

      before { expect(Invite).to receive(:find).with(89).and_return(:parent) }

      its(:parent) { should eq :parent }
    end
  end

  describe '#build_resource' do
    before { expect(subject).to receive(:parent).and_return(:parent) }

    before { expect(Invite::Reject).to receive(:new).with(:parent).and_return(:resource) }

    before { subject.send :build_resource }

    its(:resource) { should eq :resource }
  end
end
