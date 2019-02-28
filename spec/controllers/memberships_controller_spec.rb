require 'rails_helper'

RSpec.describe MembershipsController, type: :controller do
  it_behaves_like :index

  it_behaves_like :index, params: { group_id: 3 }

  it_behaves_like :new, params: { group_id: 3 }

  it_behaves_like :create, params: { group_id: 4 } do
    let(:group) { stub_model Group }

    let(:resource) { double group: group }

    let(:success) { -> { should redirect_to group } }

    let(:failure) { -> { should render_template :new } }
  end

  it_behaves_like :destroy do
    let(:group) { stub_model Group }

    let(:resource) { double group: group }

    let(:success) { -> { should redirect_to group } }
  end

  describe '#parent' do
    context do
      before { expect(subject).to receive(:params).and_return(group_id: 17) }

      before { subject.instance_variable_set :@parent, :parent }

      its(:parent) { should eq :parent }
    end

    context do
      before { expect(subject).to receive(:params).twice.and_return(group_id: 17) }

      before { expect(Group).to receive(:find).with(17).and_return(:parent) }

      its(:parent) { should eq :parent }
    end

    context do
      before { expect(subject).to receive(:params).and_return(Hash.new) }

      before { expect(Group).to_not receive(:find) }

      its(:parent) { should be_nil }
    end
  end

  describe '#collection' do
    context do
      before { subject.instance_variable_set :@collection, :collection }

      its(:collection) { should eq :collection }
    end

    context do
      before { expect(subject).to receive(:params).and_return(page: 6) }

      before do
        #
        # parent.pending_memberships.order(id: :desc).page(6) -> :collection
        #
        expect(subject).to receive_message_chain(:parent, :pending_memberships, :order).with(id: :desc) do
          double.tap { |a| expect(a).to receive(:page).with(6).and_return(:collection) }
        end
      end

      its(:collection) { should eq :collection }
    end

    context do
      before { expect(subject).to receive(:params).and_return(page: 6) }

      before { expect(subject).to receive(:parent).and_return(nil) }

      before do
        #
        # parent.pending_memberships.order(id: :desc).page(6) -> :collection
        #
        expect(subject).to receive_message_chain(:current_user, :pending_memberships, :order).with(id: :desc) do
          double.tap { |a| expect(a).to receive(:page).with(6).and_return(:collection) }
        end
      end

      its(:collection) { should eq :collection }
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

  its(:resource_params) { should eq state: :accepted }

  describe '#create_resource_params' do
    let(:params) { acp membership: { user_id: '', type: '' } }

    before { expect(subject).to receive(:params).and_return(params) }

    before { expect(subject).to receive(:parent).and_return(:parent) }

    its(:create_resource_params) { should eq params[:membership].permit!.merge(group: :parent) }
  end

  describe '#initialize_resource' do
    before do
      expect(subject).to receive_message_chain(:parent, :pending_memberships, :new).with(no_args).and_return(:resource)
    end

    before { subject.send :initialize_resource }

    its(:resource) { should eq :resource }
  end

  describe '#build_resource' do
    before { expect(subject).to receive(:create_resource_params).and_return(:params) }

    before { expect(subject).to receive(:current_user).and_return(:current_user) }

    before { expect(MembershipFactory).to receive(:build).with(:current_user, :params).and_return(:resource) }

    before { subject.send :build_resource }

    its(:resource) { should eq :resource }
  end

  describe '#policy' do
    context do
      let(:record) { stub_model Problem }

      it { expect(subject.send :policy, record).to be_a(ProblemPolicy) }
    end

    context do
      let(:record) { stub_model Membership }

      before { expect(subject).to receive(:current_user).and_return(:current_user) }

      before { expect(subject).to receive(:parent).and_return(:parent) }

      before { expect(MembershipPolicy).to receive(:new).with(:current_user, record, parent: :parent).and_return(:policy) }

      it { expect(subject.send :policy, record).to eq(:policy) }
    end
  end
end
