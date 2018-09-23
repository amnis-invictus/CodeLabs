require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  it_behaves_like :create, anonymous: true do
    let(:resource) { double }

    let(:success) { -> { should redirect_to %i(new session) } }

    let(:failure) { -> {  should render_template :new } }
  end

  describe '#resource' do
    before { subject.instance_variable_set :@resource, :resource }

    its(:resource) { should eq :resource }
  end

  describe '#resource_params' do
    let(:params) { acp user: { email: 'one@users.com', password: 'password', password_confirmation: 'password' } }

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
