require 'rails_helper'

RSpec.describe Api::Worker::SessionPolicy do
  subject { described_class }

  fixtures :workers

  let(:resource) { Api::Worker::Session.new workers worker_name }

  permissions :new?, :create? do
    context do
      let(:worker_name) { :disabled }

      it { should permit nil, resource }
    end

    context do
      let(:worker_name) { :ok }

      it { should_not permit nil, resource }
    end

    context do
      let(:worker_name) { :stale }

      it { should_not permit nil, resource }
    end

    context do
      let(:worker_name) { :stopped }

      it { should_not permit nil, resource }
    end

    context do
      let(:worker_name) { :failed }

      it { should_not permit nil, resource }
    end
  end

  permissions :destroy? do
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
