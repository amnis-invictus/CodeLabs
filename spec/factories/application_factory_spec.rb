require 'rails_helper'

RSpec.describe ApplicationFactory do
  let(:described_class) do
    Class.new ApplicationFactory do
      def initialize *args; end
    end
  end

  describe '.build' do
    after { described_class.build :params }

    it do
      #
      # described_class.new(:params).build
      #
      expect(described_class).to receive(:new).with(:params) do
        double.tap { |a| expect(a).to receive(:build) }
      end
    end
  end
end
