require 'rails_helper'

RSpec.describe Api::ApplicationController, type: :controller do
  its(:current_user) { should be_nil }

  its(:default_url_options) { should eq({}) }

  describe '#authenticate!' do
    let(:uuid) { SecureRandom.uuid }

    before { ENV['API_ACCESS_TOKEN'] = uuid }

    after { subject.send :authenticate! }

    context do
      before { expect(subject).to receive(:params).and_return({}) }

      it { expect(subject).to receive(:head).with(:unauthorized) }
    end

    context do
      before { expect(subject).to receive(:params).and_return(access_token: 'invalid') }

      it { expect(subject).to receive(:head).with(:unauthorized) }
    end

    context do
      before { expect(subject).to receive(:params).and_return(access_token: uuid) }

      it { expect(subject).to_not receive(:head) }
    end
  end

  describe '#set_locale' do
    after { I18n.locale = I18n.default_locale }

    before { subject.send :set_locale }

    it { expect(I18n.locale).to eq(:en) }
  end
end
