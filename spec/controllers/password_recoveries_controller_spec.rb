require 'rails_helper'

RSpec.describe PasswordRecoveriesController, type: :controller do
  it_behaves_like :new, anonymous: true

  describe '#create' do
    let(:resource) { double }

    it_behaves_like :create, anonymous: true do
      let(:success) { -> { should render_template :create } }

      let(:failure) { -> {  should render_template :create } }

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

  describe '#resource_params' do
    let(:params) { acp password_recovery: { email: 'one@users.com' } }

    before { expect(subject).to receive(:params).and_return(params) }

    its(:resource_params) { should eq params[:password_recovery].permit! }
  end

  describe '#resource' do
    before { subject.instance_variable_set :@resource, :resource }

    its(:resource) { should eq :resource }
  end

  describe '#build_resource' do
    before { expect(subject).to receive(:resource_params).and_return(:resource_params) }

    before { expect(PasswordRecovery).to receive(:new).with(:resource_params).and_return(:resource) }

    before { subject.send :build_resource}

    its(:resource) { should eq :resource }
  end

  describe '#initialize_resource' do
    before { expect(PasswordRecovery).to receive(:new).with(no_args).and_return(:resource) }

    before { subject.send :initialize_resource}

    its(:resource) { should eq :resource }
  end
end
