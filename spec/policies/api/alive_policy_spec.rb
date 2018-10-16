require 'rails_helper'

RSpec.describe Api::AlivePolicy do
  subject { described_class }

  fixtures :workers

  let(:resource) { Api::Alive.new workers(worker_name), name: 'new name' }

  permissions :new?, :create? do
    context do
      let(:worker_name) { :disabled }

      it { should_not permit nil, resource }
    end

    context do
      let(:worker_name) { :ok }

      it { should permit nil, resource }
    end

    context do
      let(:worker_name) { :stale }

      it { should permit nil, resource }
    end

    context do
      let(:worker_name) { :stopped }

      it { should permit nil, resource }
    end

    context do
      let(:worker_name) { :failed }

      it { should permit nil, resource }
    end
  end
end
