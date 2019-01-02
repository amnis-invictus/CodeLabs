require 'rails_helper'

RSpec.describe AvatarsController, type: :controller do
	it_behaves_like :create, format: :json do
		let(:resource) { double }

		let(:success) { -> { should render_template(:create).with_status(200) } }

		let(:failure) { -> { should render_template(:errors).with_status(422) } }
	end

	it_behaves_like :destroy do
		let(:success) { -> { should respond_with 204 } }
	end

	describe '#resource' do
		context do
			before { subject.instance_variable_set :@resource, :resource }

			its(:resource) { should eq :resource }
		end

		context do
			before { expect(subject).to receive(:build_resource).and_return(:resource) }

			its(:resource) { should eq :resource }
		end
	end

	describe '#build_resource' do
		before { expect(subject).to receive(:resource_params).and_return(:resource_params) }

		before { expect(Avatar).to receive(:new).with(:resource_params).and_return(:resource) }

		before { subject.send :build_resource }

		its(:resource) { should eq :resource }
  end

  describe '#resource_params' do
    let(:params) { acp avatar: { file: '' } }

    before { expect(subject).to receive(:params).and_return(params) }

    before { expect(subject).to receive(:current_user).and_return(:current_user) }

    its(:resource_params) { should eq params[:avatar].permit!.merge(user: :current_user) }
  end
end
