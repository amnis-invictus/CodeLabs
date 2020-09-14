require 'rails_helper'

RSpec.describe Api::ApplicationController, type: :controller do
  its(:current_user) { should be_nil }

  its(:default_url_options) { should eq Hash.new }

  describe '#authenticate!' do
    let(:hash) { '$2a$12$P9FY1uI4pexijYtWXIW2pufjvBs/Om4uz9Gf4lDbuj8E8oUrFZ/OG' }

    after { subject.send :authenticate! }

    context do
      before { expect(subject).to receive(:params).and_return({}) }

      it { expect(subject).to receive(:head).with(401) }
    end

    context do
      before { expect(subject).to receive(:params).and_return(access_token: 'invalid') }

      it { expect(subject).to receive(:head).with(401) }
    end

    context do
      before { expect(subject).to receive(:params).and_return(access_token: hash) }

      before { expect(subject).to receive(:valid_access_token?).and_return(false) }

      it { expect(subject).to receive(:head).with(401) }
    end

    context do
      before { expect(subject).to receive(:params).and_return(access_token: hash) }

      before { expect(subject).to receive(:valid_access_token?).and_return(true) }

      it { expect(subject).to_not receive(:head) }
    end
  end

  describe '#valid_access_token?' do
    let(:uuid) { SecureRandom.uuid }

    let(:corrent_hash) { BCrypt::Password.create uuid }

    let(:wrong_hash) { BCrypt::Password.create 'xxxx' }

    before { ENV['API_ACCESS_TOKEN'] = uuid }

    after { $redis_workers.keys('*').each { |k| $redis_workers.del k } }

    context do
      before { expect(subject).to receive(:params).and_return(access_token: wrong_hash.to_s) }

      after { expect($redis_workers.keys '*').to eq([]) }

      its(:valid_access_token?) { should be false }
    end

    context do
      before { expect(subject).to receive(:params).and_return(access_token: corrent_hash.to_s) }

      before { $redis_workers.set corrent_hash.salt, nil }

      after { expect($redis_workers.keys '*').to eq([corrent_hash.salt]) }

      its(:valid_access_token?) { should be false }
    end

    context do
      before { expect(subject).to receive(:params).and_return(access_token: corrent_hash.to_s) }

      after { expect($redis_workers.keys '*').to eq([corrent_hash.salt]) }

      after { expect($redis_workers.ttl corrent_hash.salt).to eq(86400) }

      its(:valid_access_token?) { should be true }
    end
  end

  describe '#set_locale' do
    after { I18n.locale = I18n.default_locale }

    before { subject.send :set_locale }

    it { expect(I18n.locale).to eq(:en) }
  end
end
