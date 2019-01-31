require 'rails_helper'

RSpec.describe GroupsController, type: :controller do
  it_behaves_like :index

  it_behaves_like :show

  it_behaves_like :new

  it_behaves_like :edit

  it_behaves_like :create do
    let(:resource) { stub_model Group }

    let(:success) { -> { should redirect_to resource } }

    let(:failure) { -> { should render_template :new } }
  end

  it_behaves_like :update do
    let(:resource) { stub_model Group }

    let(:success) { -> { should redirect_to resource } }

    let(:failure) { -> { should render_template :edit } }
  end

  it_behaves_like :destroy do
    let(:success) { -> { should redirect_to :groups } }
  end

  describe '#resource' do
    context do
      before { subject.instance_variable_set :@resource, :resource }

      its(:resource) { should eq :resource }
    end

    context do
      before { expect(subject).to receive(:params).and_return(id: 18) }

      before do
        #
        # Group.find(18).decorate -> :resource
        #
        expect(Group).to receive(:find).with(18) do
          double.tap { |a| expect(a).to receive(:decorate).and_return(:resource) }
        end
      end

      its(:resource) { should eq :resource }
    end
  end

  describe '#collection' do
    context do
      before { subject.instance_variable_set :@collection, :collection }

      its(:collection) { should eq :collection }
    end

    context do
      before { expect(subject).to receive(:params).and_return(page: 22) }

      before do
        #
        # Group.includes(:owner).order(:name).page(22) -> :collection
        #
        expect(Group).to receive(:includes).with(:owner) do
          double.tap do |a|
            expect(a).to receive(:order).with(:name) do
              double.tap { |b| expect(b).to receive(:page).with(22).and_return(:collection) }
            end
          end
        end
      end

      its(:collection) { should eq :collection }
    end
  end

  describe '#resource_params' do
    let(:params) { acp group: { name: '', visibility: '', description: '' } }

    before { expect(subject).to receive(:params).and_return(params) }

    its(:resource_params) { should eq params[:group].permit! }
  end

  describe '#initialize_resource' do
    before { expect(subject).to receive_message_chain(:current_user, :owned_groups, :new).and_return(:resource) }

    before { subject.send :initialize_resource }

    its(:resource) { should eq :resource }
  end

  describe '#build_resource' do
    before { expect(subject).to receive(:resource_params).and_return(:params) }

    before do
      expect(subject).to receive_message_chain(:current_user, :owned_groups, :new).with(:params).and_return(:resource)
    end

    before { subject.send :build_resource }

    its(:resource) { should eq :resource }
  end
end
