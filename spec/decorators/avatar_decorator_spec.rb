require 'rails_helper'

RSpec.describe AvatarDecorator do
  let(:resource) { Avatar.new }

  subject { resource.decorate }

  describe '#as_json' do
    before { expect(subject).to receive(:url).and_return(:url) }

    its(:as_json) { should eq url: :url }
  end

  describe '#url' do
    before { allow(subject).to receive_message_chain(:user, :avatar).and_return(avatar) }

    context do
      let(:avatar) { double attached?: false }

      its(:url) { should be_nil }
    end

    context do
      let(:avatar) { double attached?: true }

      let(:options) { { resize: '300x400^', crop: '300x400+0+0', gravity: 'center' } }

      before { expect(avatar).to receive(:variant).with(combine_options: options).and_return(:variant) }

      before { expect(subject).to receive_message_chain(:helpers, :url_for).with(:variant).and_return(:url) }

      its(:url) { should eq :url }
    end
  end
end
