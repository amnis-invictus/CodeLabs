require 'rails_helper'

RSpec.describe VersionAdapter do
  describe '.string_to_array' do
    subject { described_class.string_to_array version }

    context do
      let(:version) { '1.0.7784.34987' }

      it { should eq [1, 0, 7_784, 34_987] }
    end

    context do
      let(:version) { '' }

      it { should eq [] }
    end

    context do
      let(:version) { nil }

      it { should eq [] }
    end

    context do
      let(:version) { 'something other' }

      it { should eq [0] }
    end
  end

  describe '.array_to_string' do
    subject { described_class.array_to_string version }

    context do
      let(:version) { [1, 0, 7_784, 34_987] }

      it { should eq '1.0.7784.34987' }
    end

    context do
      let(:version) { [] }

      it { should eq '' }
    end

    context do
      let(:version) { nil }

      it { should eq '' }
    end

    context do
      let(:version) { 'something else' }

      it { should eq '' }
    end
  end
end
