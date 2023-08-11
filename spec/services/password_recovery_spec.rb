require 'rails_helper'

RSpec.describe PasswordRecovery, type: :model do
  subject { described_class.new email: 'one@users.com', password: 'password' }

  its(:email) { should eq 'one@users.com' }

  its(:to_key) { should be_nil }

  its(:persisted?) { should be false }

  describe '#valid?' do
    before { expect(subject).to receive(:user_must_be_present) }

    it { should validate_presence_of :email }
  end

  describe '#save' do
    context do
      let(:user) { stub_model User }

      before { expect(subject).to receive(:valid?).and_return(true) }

      before { expect(SecureRandom).to receive(:uuid).and_return(:uuid) }

      before { expect(subject).to receive(:user).twice.and_return(user) }

      before { expect(user).to receive(:update!).with(password_recovery_token: :uuid) }

      before do
        #
        # PasswordRecoveryMailer.email(user).deliver_later
        #
        expect(PasswordRecoveryMailer).to receive(:email).with(user) do
          double.tap { |a| expect(a).to receive(:deliver_later) }
        end
      end

      it { expect { subject.save }.to_not raise_error }
    end

    context do
      before { expect(subject).to receive(:valid?).and_return(false) }

      before { expect(subject).to_not receive(:user) }

      it { expect { subject.save }.to_not raise_error }
    end
  end

  describe '#user' do
    context do
      before { subject.instance_variable_set :@user, :user }

      its(:user) { should eq :user }
    end

    context do
      before { expect(User).to receive(:find_by).with('lower(email) = lower(?)', 'one@users.com').and_return(:user) }

      its(:user) { should eq :user }
    end
  end

  describe '#user_must_be_present' do
    let(:call) { -> { subject.send :user_must_be_present } }

    let(:errors) { -> { subject.errors.details.to_h } }

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
end
