require 'rails_helper'

RSpec.describe Api::Alive do
  fixtures :workers

  let(:worker) { workers :ok }

  subject { described_class.new worker, name: 'new name' }

  its(:worker) { should eq worker }

  its(:params) { should eq name: 'new name' }

  it { should delegate_method(:disabled?).to(:worker).with_prefix }

  it { should delegate_method(:ok?).to(:worker).with_prefix }

  it { should delegate_method(:failed?).to(:worker).with_prefix }

  it { should delegate_method(:stale?).to(:worker).with_prefix }

  it { should delegate_method(:stopped?).to(:worker).with_prefix }

  describe '#save' do
    before { allow(Time).to receive_message_chain(:zone, :now).and_return('12.10.2018 13:34:11') }

    it { expect(worker).to receive(:update).with(name: 'new name', alive_at: '12.10.2018 13:34:11') }

    after { subject.save }
  end
end
