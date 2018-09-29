require 'rails_helper'

RSpec.describe ProfilesController, type: :controller do
  it_behaves_like :show

  it_behaves_like :update do
    let(:resource) { double }

    let :success do
      lambda do
        should set_flash.now[:success]

        should render_template :show
      end
    end

    let(:failure) { -> { should render_template :show } }
  end

  it { expect(subject.method(:resource).original_name).to eq :current_user }

  describe '#resource_params' do
    let :params do
      acp user: {
        name: 'Pikachu',
        password: 'password',
        password_confirmation: 'password',
        avatar: '',
        skills: ['lighting rod', 'elecro ball']
      }
    end

    before { expect(subject).to receive(:params).and_return(params) }

    its(:resource_params) { should eq params[:user].permit! }
  end
end