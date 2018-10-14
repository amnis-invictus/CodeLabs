require 'rails_helper'

RSpec.describe InvitesController, type: :controller do
  it_behaves_like :index, params: { group_id: 95 }

  it_behaves_like :new, params: { group_id: 95 }

  it_behaves_like :create, params: { group_id: 95 } do
    let(:resource) { double }

    let(:parent) { stub_model Group, id: 95 }

    before { allow(subject).to receive(:parent).and_return(parent) }

    let(:success) { -> { should redirect_to parent } }

    let(:failure) { -> { should render_template :new } }
  end

  describe '#collection' do
    context do
      before { subject.instance_variable_set :@collection, :collection }

      its(:collection) { should eq :collection }
    end

    context do
      before { expect(subject).to receive(:params).and_return(page: 8) }

      before do
        #
        # subject.parent.invites.order(id: :desc).page(8) -> :collection
        #
        expect(subject).to receive_message_chain(:parent, :invites, :order).with(id: :desc) do
          double.tap { |a| expect(a).to receive(:page).with(8).and_return(:collection) }
        end
      end

      its(:collection) { should eq :collection }
    end
  end

  describe '#parent' do
    context do
      before { subject.instance_variable_set :@parent, :parent }

      its(:parent) { should eq :parent }
    end

    context do
      before { expect(subject).to receive(:params).and_return(group_id: 21) }

      before { expect(Group).to receive(:find).with(21).and_return(:parent) }

      its(:parent) { should eq :parent }
    end
  end

  describe '#resource_params' do
    let(:params) { acp invite: { receiver_id: '52' } }

    before { expect(subject).to receive(:params).and_return(params) }

    before { expect(subject).to receive(:current_user).and_return(:current_user) }

    its(:resource_params) { should eq params[:invite].permit!.merge(sender: :current_user) }
  end

  describe '#initialize_resource' do
    before { expect(subject).to receive_message_chain(:parent, :invites, :new).and_return(:resource) }

    before { subject.send :initialize_resource }

    its(:resource) { should eq :resource }
  end

  describe '#build_resource' do
    before { expect(subject).to receive(:resource_params).and_return(:resource_params) }

    before { expect(subject).to receive_message_chain(:parent, :invites, :new).with(:resource_params).and_return(:resource) }

    before { subject.send :build_resource }

    its(:resource) { should eq :resource }
  end
end
