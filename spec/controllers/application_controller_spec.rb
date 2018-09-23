require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  its(:default_url_options) { should eq language: :en }

  describe '#current_user' do
    before { allow(subject).to receive_message_chain(:cookies, :encrypted, :[]).with(:auth_token).and_return(auth_token) }

    context do
      let (:auth_token) { nil }

      its(:current_user) { should be_nil }
    end

    context do
      let(:auth_token) { :auth_token }

      before { subject.instance_variable_set :@current_user, :current_user }

      its(:current_user) { should eq :current_user }
    end

    context do
      let(:auth_token) { :auth_token }

      before do
        #
        # User.joins(:auth_tokens).find_by(auth_tokens: { id: :auth_token }) -> :current_user
        #
        expect(User).to receive(:joins).with(:auth_tokens) do
          double.tap { |a| expect(a).to receive(:find_by).with(auth_tokens: { id: :auth_token }).and_return(:current_user) }
        end
      end

      its(:current_user) { should eq :current_user }
    end
  end

  describe '#authenticate!' do
    after { subject.send :authenticate! }

    before { allow(subject).to receive_message_chain(:request, :fullpath).and_return('/profile') }

    context do
      before { expect(subject).to receive(:current_user).and_return(nil) }

      it { expect(subject).to receive(:redirect_to).with([:new, :session, redirect: '/profile']) }
    end

    context do
      before { expect(subject).to receive(:current_user).and_return(:current_user) }

      it { expect(subject).to_not receive(:redirect_to) }
    end
  end

  describe '#authorize_resource' do
    before { subject.define_singleton_method(:resource) { :resource } }

    before { expect(subject).to receive(:authorize).with(:resource).and_return(true) }

    it { expect(subject.send(:authorize_resource)).to eq(true) }
  end

  describe '#authorize_collection' do
    before { subject.define_singleton_method(:collection) { :collection } }

    before { expect(subject).to receive(:authorize).with(:collection).and_return(true) }

    it { expect(subject.send(:authorize_collection)).to eq(true) }
  end

  describe '#set_locale' do
    after { I18n.locale = I18n.default_locale }

    before { allow(subject).to receive(:params).and_return(params) }

    before { subject.send :set_locale }

    context do
      let(:params) { { language: 'ru' } }

      it { expect(I18n.locale).to eq(:ru) }
    end

    context do
      let(:params) { { language: 'invalid' } }

      it { expect(I18n.locale).to eq(:en) }
    end

    context do
      let(:params) { { } }

      it { expect(I18n.locale).to eq(:en) }
    end
  end
end
