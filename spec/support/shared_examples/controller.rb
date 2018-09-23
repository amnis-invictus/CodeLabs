RSpec.shared_examples :show do |params|
  let(:default_params) { { anonymous: false, unauthorized: false, format: :html, params: { id: 1 } } }

  let(:resource) { double }

  include_examples :parse_params, params

  include_examples :authenticate_user

  include_examples :authorize_resource

  describe '#show' do
    before { allow(subject).to receive(:resource).and_return(resource) }

    before { get :show, params: request_params, format: format }

    it { should render_template :show }
  end
end

RSpec.shared_examples :new do |params|
  let(:default_params) { { anonymous: false, unauthorized: false, format: :html, params: {} } }

  let(:resource) { :resource }

  include_examples :parse_params, params

  include_examples :authenticate_user

  include_examples :authorize_resource

  describe '#new' do
    before { allow(subject).to receive(:resource).and_return(resource) }

    before { expect(subject).to receive(:initialize_resource) }

    before { get :new, params: request_params, format: format }

    it { should render_template :new }
  end
end

RSpec.shared_examples :create do |params|
  let(:default_params) { { anonymous: false, unauthorized: false, format: :html, params: {} } }

  include_examples :parse_params, params

  include_examples :authenticate_user

  include_examples :authorize_resource

  describe '#create' do
    before { allow(subject).to receive(:resource).and_return(resource) }

    before { expect(subject).to receive(:build_resource) }

    context do
      before { expect(resource).to receive(:save).and_return(true) }

      before { post :create, params: request_params, format: format }

      it { success.call }
    end

    context do
      before { expect(resource).to receive(:save).and_return(false) }

      before { post :create, params: request_params, format: format }

      it { failure.call }
    end
  end
end

RSpec.shared_examples :edit do |params|
  let(:default_params) { { anonymous: false, unauthorized: false, format: :html, params: { id: 1 } } }

  let(:resource) { :resource }

  include_examples :parse_params, params

  include_examples :authenticate_user

  include_examples :authorize_resource

  describe '#edit' do
    before { allow(subject).to receive(:resource).and_return(resource) }

    before { get :edit, params: request_params, format: format }

    it { should render_template :edit }
  end
end

RSpec.shared_examples :update do |params|
  let(:default_params) { { anonymous: false, unauthorized: false, format: :html, params: { id: 1 } } }

  include_examples :parse_params, params

  include_examples :authenticate_user

  include_examples :authorize_resource

  describe '#update' do
    before { allow(subject).to receive(:resource).and_return(resource) }

    before { expect(subject).to receive(:resource_params).and_return(:resource_params) }

    context do
      before { expect(resource).to receive(:update).with(:resource_params).and_return(true) }

      before { patch :update, params: request_params, format: format }

      it { success.call }
    end

    context do
      before { expect(resource).to receive(:update).with(:resource_params).and_return(false) }

      before { patch :update, params: request_params, format: format }

      it { failure.call }
    end
  end
end

RSpec.shared_examples :destroy do |params|
  let(:default_params) { { anonymous: false, unauthorized: false, format: :html, params: { id: 1 } } }

  let(:resource) { double }

  include_examples :parse_params, params

  include_examples :authenticate_user

  include_examples :authorize_resource

  describe '#destroy' do
    before { allow(subject).to receive(:resource).and_return(resource) }

    before { expect(resource).to receive(:destroy) }

    before { delete :destroy, params: request_params, format: format }

    it { success.call }
  end
end

RSpec.shared_examples :index do |params|
  let(:default_params) { { anonymous: false, unauthorized: false, format: :html, params: {} } }

  include_examples :parse_params, params

  include_examples :authenticate_user

  describe '#index' do
    before { expect(subject).to receive(:authorize_collection).and_return(true) unless unauthorized }

    before { get :index, params: request_params, format: format }

    it { should render_template :index }
  end
end

#
# Helpers
#

RSpec.shared_examples :parse_params do |params|
  let(:anonymous) { (params && params[:anonymous]) || default_params[:anonymous] }

  let(:unauthorized) { (params && params[:unauthorized]) || default_params[:unauthorized] }

  let(:format) { (params && params[:format]) || default_params[:format] }

  let(:request_params) { (params && params[:params]) || default_params[:params] }

  let(:policy) { (params && params[:policy]) || default_params[:policy] }
end

RSpec.shared_examples :authenticate_user do
  before { expect(subject).to receive(:authenticate!) unless anonymous }
end

RSpec.shared_examples :authorize_resource do
  before { expect(subject).to receive(:authorize).with(resource).and_return(true) unless unauthorized }
end
