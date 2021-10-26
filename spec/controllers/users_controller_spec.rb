require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  it_behaves_like :index, format: :json

  describe '#create' do
    let(:resource) { double }

    it_behaves_like :create, anonymous: true do
      let(:success) { -> { should redirect_to %i[new session] } }

      let(:failure) { -> { should render_template :new } }

      before { expect(subject).to receive(:verify_recaptcha).and_return(true) }
    end

    context do
      before { allow(subject).to receive(:resource).and_return(resource) }

      before { expect(subject).to receive(:authorize).with(resource).and_return(true) }

      before { expect(subject).to receive(:build_resource) }

      before { expect(subject).to receive(:verify_recaptcha).and_return(false) }

      before { expect(resource).to_not receive(:save) }

      before { post :create, format: :html }

      it { should render_template :new }
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
      before { expect(subject).to receive(:params).and_return(name: 'John', page: '28').twice }

      before do
        #
        # UserSearcher.search(User, name: 'John', page: '28').page('28') -> :collection
        #
        expect(UserSearcher).to receive(:search).with(User, name: 'John', page: '28') do
          double.tap { |a| expect(a).to receive(:page).with('28').and_return(:collection) }
        end
      end

      its(:collection) { should eq :collection }
    end
  end

  describe '#resource_params' do
    let :params do
      acp user: { username: 'just806me', email: 'one@users.com', password: 'password', password_confirmation: 'password' }
    end

    before { expect(subject).to receive(:params).and_return(params) }

    its(:resource_params) { should eq params[:user].permit! }
  end

  describe '#initialize_resource' do
    before { expect(User).to receive(:new).and_return(:resource) }

    before { subject.send :initialize_resource }

    its(:resource) { should eq :resource }
  end

  describe '#build_resource' do
    before { expect(subject).to receive(:resource_params).and_return(:resource_params) }

    before { expect(User).to receive(:new).with(:resource_params).and_return(:resource) }

    before { subject.send :build_resource }

    its(:resource) { should eq :resource }
  end
end
