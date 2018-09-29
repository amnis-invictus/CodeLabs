require 'rails_helper'

RSpec.describe ArchivesController, type: :controller do
  it_behaves_like :new

  it_behaves_like :create do
    let(:resource) { double }

    let(:success) { -> { should respond_with 204 } }

    let(:failure) { -> { should render_template :new } }
  end

  describe '#resource' do
    before { subject.instance_variable_set :@resource, :resource }

    its(:resource) { should eq :resource }
  end

  describe '#resource_params' do
    let(:params) { acp archive: { file: '', channel_id: 'XXX-YYY-ZZZ' } }

    before { expect(subject).to receive(:params).and_return(params) }

    before { expect(subject).to receive(:current_user).and_return(:current_user) }

    its(:resource_params) { should eq params[:archive].permit!.merge(user: :current_user) }
  end

  describe '#initialize_resource' do
    before { expect(SecureRandom).to receive(:uuid).and_return('XXX-YYY-ZZZ') }

    before { expect(Archive).to receive(:new).with(channel_id: 'XXX-YYY-ZZZ').and_return(:resource) }

    before { subject.send :initialize_resource }

    its(:resource) { should eq :resource }
  end

  describe '#build_resource' do
    before { expect(subject).to receive(:resource_params).and_return(:resource_params) }

    before { expect(Archive).to receive(:new).with(:resource_params).and_return(:resource) }

    before { subject.send :build_resource }

    its(:resource) { should eq :resource }
  end
end
