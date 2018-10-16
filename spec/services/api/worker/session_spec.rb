require 'rails_helper'

RSpec.describe Api::Worker::Session do
  fixtures :workers

  let(:worker) { workers :ok }

  subject { described_class.new worker }

  its(:worker) { should eq worker }

  it { should delegate_method(:disabled?).to(:worker).with_prefix }

  it { should delegate_method(:ok?).to(:worker).with_prefix }

  it { should delegate_method(:failed?).to(:worker).with_prefix }

  it { should delegate_method(:stale?).to(:worker).with_prefix }

  it { should delegate_method(:stopped?).to(:worker).with_prefix }

  describe '#save' do
    before { allow(Time).to receive_message_chain(:zone, :now).and_return('12.10.2018 13:34:11') }

    it { expect(worker).to receive(:update).with(alive_at: '12.10.2018 13:34:11', status: :ok) }

    after { subject.save }
  end

  describe '#destroy' do
    before { allow(Time).to receive_message_chain(:zone, :now).and_return('12.10.2018 13:34:11') }

    it { expect(worker).to receive(:update).with(alive_at: '12.10.2018 13:34:11', status: :disabled, task_status: []) }

    after { subject.destroy }
  end
end
