require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  it_behaves_like :new, anonymous: true

  describe '#create' do
    let(:resource) { Session.new auth_token: stub_model(AuthToken, id: '408a0176-06ef-430e-a97e-634cfb5bdfc4') }

    let(:failure) { -> { should render_template :new } }

    context do
      let :success do
        lambda do
          expect(cookies.encrypted[:auth_token]).to eq('408a0176-06ef-430e-a97e-634cfb5bdfc4')

          should redirect_to :profile
        end
      end

      it_behaves_like :create, anonymous: true
    end

    context do
      let :success do
        lambda do
          expect(cookies.encrypted[:auth_token]).to eq('408a0176-06ef-430e-a97e-634cfb5bdfc4')

          expect(session[:redirect]).to be_nil

          should redirect_to '/problems/1'
        end
      end

      before { session[:redirect] = '/problems/1' }

      it_behaves_like :create, anonymous: true
    end
  end

  it_behaves_like :destroy do
    before { cookies.encrypted[:auth_token] = :uuid }

    let :success do
      lambda do
        expect(cookies.encrypted[:auth_token]).to be_nil

        should redirect_to :root
      end
    end
  end

  describe '#resource' do
    context do
      before { subject.instance_variable_set :@resource, :resource }

      its(:resource) { should eq :resource }
    end

    context do
      before { expect(subject).to receive_message_chain(:cookies, :encrypted, :[]).with(:auth_token).and_return(:uuid) }

      before { expect(AuthToken).to receive(:find).with(:uuid).and_return(:auth_token) }

      before { expect(Session).to receive(:new).with(auth_token: :auth_token).and_return(:resource) }

      its(:resource) { should eq :resource }
    end
  end

  describe '#resource_params' do
    let(:params) { acp session: { email: 'one@users.com', password: 'password' } }

    before { expect(subject).to receive(:params).and_return(params) }

    its(:resource_params) { should eq params[:session].permit! }
  end

  describe '#initialize_resource' do
    before { expect(Session).to receive(:new).and_return(:resource) }

    before { subject.send :initialize_resource }

    its(:resource) { should eq :resource }
  end

  describe '#build_resource' do
    before { expect(subject).to receive(:resource_params).and_return(:resource_params) }

    before { expect(Session).to receive(:new).with(:resource_params).and_return(:resource) }

    before { subject.send :build_resource }

    its(:resource) { should eq :resource }
  end
end
