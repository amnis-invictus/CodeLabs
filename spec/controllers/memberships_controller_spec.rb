require 'rails_helper'

RSpec.describe MembershipsController, type: :controller do
  it_behaves_like :create, params: { group_id: 4 } do
    let(:group) { stub_model Group }

    let(:resource) { double group: group }

    let(:success) { -> { should redirect_to group } }

    let(:failure) { -> { should redirect_to group } }
  end

  it_behaves_like :destroy do
    let(:group) { stub_model Group }

    let(:resource) { double group: group }

    let(:success) { -> { should redirect_to group } }
  end

  describe '#parent' do
    context do
      before { subject.instance_variable_set :@parent, :parent }

      its(:parent) { should eq :parent }
    end

    context do
      before { expect(subject).to receive(:params).and_return(group_id: 17) }

      before { expect(Group).to receive(:find).with(17).and_return(:parent) }

      its(:parent) { should eq :parent }
    end
  end

  describe '#resource' do
    context do
      before { subject.instance_variable_set :@resource, :resource }

      its(:resource) { should eq :resource }
    end

    context do
      before { expect(subject).to receive(:params).and_return(id: 91) }

      before { expect(Membership).to receive(:find).with(91).and_return(:resource) }

      its(:resource) { should eq :resource }
    end
  end

  describe '#resource_params' do
    let(:params) { acp membership: { user_id: '', type: '' } }

    before { expect(subject).to receive(:params).and_return(params) }

    before { expect(subject).to receive(:parent).and_return(:parent) }

    its(:resource_params) { should eq params[:membership].permit!.merge(group: :parent) }
  end

  describe '#build_resource' do
    before { expect(subject).to receive(:resource_params).and_return(:resource_params) }

    before { expect(subject).to receive(:current_user).and_return(:current_user) }

    before { expect(MembershipFactory).to receive(:build).with(:current_user, :resource_params).and_return(:resource) }

    before { subject.send :build_resource }

    its(:resource) { should eq :resource }
  end
end
