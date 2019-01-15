require 'rails_helper'

RSpec.describe Archive, type: :model do
  let(:uuid) { SecureRandom.uuid }

  let(:user) { stub_model User }

  let(:file) { ActionDispatch::Http::UploadedFile.new tempfile: double(path: '/uploads/01'), type: 'application/zip' }

  subject { described_class.new file: file, channel_id: uuid, user: user }

  its(:file) { should eq file }

  its(:channel_id) { should eq uuid }

  its(:user) { should eq user }

  its(:to_key) { should be_nil }

  its(:persisted?) { should be false }

  its(:to_model) { should eq subject }

  it { should validate_presence_of :file }

  it { should validate_presence_of :channel_id }

  it { should validate_presence_of :user }

  describe '#save' do
    context do
      before { expect(subject).to receive(:valid?).and_return(false) }

      before { expect(ProcessProblemArchiveJob).to_not receive(:perform_later) }

      its(:save) { should be false }
    end

    context do
      before { expect(subject).to receive(:valid?).and_return(true) }

      before { expect(subject).to receive(:filename).and_return('/tmp/01').twice }

      before { expect(FileUtils).to receive(:copy).with('/uploads/01', '/tmp/01') }

      before { expect(ProcessProblemArchiveJob).to receive(:perform_later).with(user, '/tmp/01', uuid) }

      its(:save) { should be true }
    end
  end

  describe '#filename' do
    context do
      before { subject.instance_variable_set :@filename, :filename }

      its(:filename) { should eq :filename }
    end

    context do
      before { expect(SecureRandom).to receive(:uuid).and_return(uuid) }

      its(:filename) { should eq File.join Dir.tmpdir, uuid }
    end
  end
end
