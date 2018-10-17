require 'rails_helper'

RSpec.describe ProblemsController, type: :controller do
  it_behaves_like :index, anonymous: true

  it_behaves_like :index, params: { tag_id: 25 }, anonymous: true

  it_behaves_like :index, params: { user_id: 25 }, anonymous: true

  it_behaves_like :show, anonymous: true

  it_behaves_like :new

  it_behaves_like :edit

  it_behaves_like :create do
    let(:resource) { stub_model Problem }

    let(:success) { -> { should redirect_to resource } }

    let(:failure) { -> { should render_template :new } }
  end

  it_behaves_like :update do
    let(:resource) { stub_model Problem }

    let(:success) { -> { should redirect_to resource } }

    let(:failure) { -> { should render_template :edit } }
  end

  it_behaves_like :destroy do
    let(:resource) { stub_model Problem }

    let(:success) { -> { should redirect_to :problems } }
  end

  pending '#resource_params'

  pending '#collection' do
    context do
      before { subject.instance_variable_set :@collection, :collection }

      its(:collection) { should eq :collection }
    end

    context do
      before { expect(subject).to receive(:params).and_return(page: 12) }

      before { expect(subject).to receive_message_chain(:parent, :problems, :page).with(12).and_return(:collection) }

      its(:collection) { should eq :collection }
    end

    context do
      before { expect(subject).to receive(:params).and_return(page: 12) }

      before { expect(subject).to receive(:parent).and_return(nil) }

      before { expect(Problem).to receive_message_chain(:all, :page).with(12).and_return(:collection) }

      its(:collection) { should eq :collection }
    end
  end

  describe '#parent' do
    context do
      before { subject.instance_variable_set :@parent, :parent }

      its(:parent) { should eq :parent }
    end

    context do
      before { allow(subject).to receive(:params).and_return(tag_id: 5) }

      before { expect(Tag).to receive(:find).with(5).and_return(:parent) }

      its(:parent) { should eq :parent }
    end

    context do
      before { allow(subject).to receive(:params).and_return(user_id: 5) }

      before { expect(User).to receive(:find).with(5).and_return(:parent) }

      its(:parent) { should eq :parent }
    end

    context do
      before { allow(subject).to receive(:params).and_return({}) }

      its(:parent) { should be_nil }
    end
  end

  describe '#resource' do
    context do
      before { subject.instance_variable_set :@resource, :resource }

      its(:resource) { should eq :resource }
    end

    context do
      before { expect(subject).to receive(:params).and_return(id: 28) }

      before do
        expect(Problem).to receive(:find).with(28) do
          double.tap { |a| expect(a).to receive(:decorate).and_return(:resource) }
        end
      end

      its(:resource) { should eq :resource }
    end
  end

  describe '#initialize_resource' do
    before { expect(subject).to receive_message_chain(:current_user, :problems, :new).and_return(:resource) }

    before { subject.send :initialize_resource }

    its(:resource) { should eq :resource }
  end

  describe '#build_resource' do
    before { expect(subject).to receive(:resource_params).and_return(:resource_params) }

    before do
      expect(subject).to receive_message_chain(:current_user, :problems, :new).with(:resource_params).and_return(:resource)
    end

    before { subject.send :build_resource }

    its(:resource) { should eq :resource }
  end
end
