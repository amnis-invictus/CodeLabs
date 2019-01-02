require 'rails_helper'

RSpec.describe Session, type: :model do
  subject { described_class.new email: 'one@users.com', password: 'password' }

  its(:email) { should eq 'one@users.com' }

  its(:password) { should eq 'password' }

  its(:to_key) { should be_nil }

  its(:persisted?) { should be false }

  it { should delegate_method(:destroy).to(:auth_token) }

  describe '#valid?' do
    before { expect(subject).to receive(:user_must_be_present) }

    before { expect(subject).to receive(:password_must_pass_authentication) }

    it { should validate_presence_of :email }

    it { should validate_presence_of :password }
  end

  describe '#save' do
    context do
      before { expect(subject).to receive(:valid?).and_return(false) }

      before { expect(subject).to_not receive(:auth_token) }

      its(:save) { should be false }
    end

    context do
      before { expect(subject).to receive(:valid?).and_return(true) }

      before { expect(subject).to receive_message_chain(:auth_token, :save).and_return(:result) }

      its(:save) { should eq :result }
    end
  end

  describe '#user' do
    context do
      before { subject.instance_variable_set :@user, :user }

      its(:user) { should eq :user }
    end

    context do
      before { expect(User).to receive(:find_by).with(email: 'one@users.com').and_return(:user) }

      its(:user) { should eq :user }
    end
  end

  describe '#auth_token' do
    context do
      before { subject.instance_variable_set :@auth_token, :auth_token }

      its(:auth_token) { should eq :auth_token }
    end

    context do
      before { expect(subject).to receive_message_chain(:user, :auth_tokens, :build).and_return(:auth_token) }

      its(:auth_token) { should eq :auth_token }
    end
  end

  describe '#user_must_be_present' do
    let(:call) { -> { subject.send :user_must_be_present } }

    let(:errors) { -> { subject.errors.details } }

    context do
      subject { described_class.new }

      it { expect(&call).to_not change(&errors) }
    end

    context do
      before { allow(subject).to receive(:user).and_return(double) }

      it { expect(&call).to_not change(&errors) }
    end

    context do
      before { allow(subject).to receive(:user).and_return(nil) }

      it { expect(&call).to change(&errors).to(email: [{ error: :invalid }]) }
    end
  end

  describe '#password_must_pass_authentication' do
    let(:call) { -> { subject.send :password_must_pass_authentication } }

    let(:errors) { -> { subject.errors.details } }

    let(:user) { double }

    before { allow(subject).to receive(:user).and_return(user) }

    context do
      subject { described_class.new }

      it { expect(&call).to_not change(&errors) }
    end

    context do
      let(:user) { nil }

      it { expect(&call).to_not change(&errors) }
    end

    context do
      before { expect(user).to receive(:authenticate).with('password').and_return(true) }

      it { expect(&call).to_not change(&errors) }
    end

    context do
      before { expect(user).to receive(:authenticate).with('password').and_return(false) }

      it { expect(&call).to change(&errors).to(password: [{ error: :invalid }]) }
    end
  end
end
