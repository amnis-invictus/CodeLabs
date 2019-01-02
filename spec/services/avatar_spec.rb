require 'rails_helper'

RSpec.describe Avatar, type: :model do
  let(:user) { double }

  let(:file) { double open: :open, original_filename: 'avatar.jpg', content_type: 'image/jpeg'  }

  subject { described_class.new user: user, file: file }

  its(:user) { should eq user }

  its(:file) { should eq file }

  it { should be_an ActiveModel::Validations }

  it { should be_a Draper::Decoratable }

  it { should delegate_method(:avatar).to(:user).allow_nil }

  it { should delegate_method(:attached?).to(:avatar).allow_nil }

  it { should delegate_method(:destroy).to(:avatar).as(:purge_later).allow_nil }

  it { should delegate_method(:as_json).to(:decorate) }

  it { should delegate_method(:url).to(:decorate) }

  describe '#valid?' do
    before { expect(subject).to receive(:blob_must_be_variable) }

    it { should validate_presence_of :user }

    it { should validate_presence_of :file }
  end

  describe '#save' do
    context do
      before { expect(subject).to receive(:valid?).and_return(true) }

      before { expect(subject).to receive(:blob).and_return(:blob) }

      before { expect(user).to receive(:avatar=).with(:blob) }
    end

    context do
      before { expect(subject).to receive(:valid?).and_return(false) }

      before { expect(subject).to_not receive(:blob) }
    end
  end

  describe '#blob' do
    context do
      before { subject.instance_variable_set :@blob, :blob }

      its(:blob) { should eq :blob }
    end

    context do
      let(:options) { { io: :open, filename: 'avatar.jpg', content_type: 'image/jpeg' } }

      before { expect(ActiveStorage::Blob).to receive(:build_after_upload).with(options).and_return(:blob) }

      its(:blob) { should eq :blob }
    end
  end

  describe '#blob_must_be_variable' do
    let(:call) { -> { subject.send :blob_must_be_variable } }

    let(:errors) { -> { subject.errors.details } }

    context do
      let(:file) { nil }

      before { expect(subject).to_not receive(:blob) }

      it { expect(&call).to_not change(&errors) }
    end

    context do
      before { expect(subject).to receive(:blob).and_return(double variable?: true) }

      it { expect(&call).to_not change(&errors) }
    end

    context do
      before { expect(subject).to receive(:blob).and_return(double variable?: false) }

      it { expect(&call).to change(&errors).to(file: [{ error: :invalid }]) }
    end
  end
end
