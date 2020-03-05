require 'rails_helper'

RSpec.describe PasswordsController, type: :controller do
  it_behaves_like :edit, anonymous: true, unauthorized: true do
    before { expect(subject).to receive(:authorize).with(resource, policy_class: PasswordPolicy).and_return(true) }
  end

  it_behaves_like :update, anonymous: true, unauthorized: true do
    let(:resource) { double }

    let :success do
      lambda do
        should set_flash[:success]

        should redirect_to %i[new session]
      end
    end

    let :failure do
      lambda do
        should set_flash.now[:error]

        render_template :edit
      end
    end

    before { expect(subject).to receive(:authorize).with(resource, policy_class: PasswordPolicy).and_return(true) }
  end

  describe '#resource' do
    context do
      before { expect(subject).to receive(:params).and_return(token: 'XXX-YYY-ZZZ') }

      before { subject.instance_variable_set :@resource, :resource }

      its(:resource) { should eq :resource }
    end

    context do
      before { expect(subject).to receive(:params).twice.and_return(token: 'XXX-YYY-ZZZ') }

      before { expect(User).to receive(:find_by).with(password_recovery_token: 'XXX-YYY-ZZZ').and_return(:resource) }

      its(:resource) { should eq :resource }
    end

    context do
      before { expect(subject).to receive(:params).and_return(Hash.new) }

      its(:resource) { should eq nil }
    end
  end

  describe '#resource_params' do
    let(:params) { acp user: { password: 'password', password_confirmation: 'password' } }

    before { expect(subject).to receive(:params).and_return(params) }

    its(:resource_params) { should eq params[:user].permit!.merge(password_recovery_token: nil) }
  end

  describe '#authorize_resource' do
    before { expect(subject).to receive(:resource).and_return(:resource) }

    before { expect(subject).to receive(:authorize).with(:resource, policy_class: PasswordPolicy).and_return(true) }

    its(:authorize_resource) { should eq true }
  end
end
