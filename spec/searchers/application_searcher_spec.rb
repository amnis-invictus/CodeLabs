require 'rails_helper'

RSpec.describe ApplicationSearcher do
  let(:relation) { double }

  let(:params) { acpp name: 'John', age: '19' }

  subject { described_class.new relation, params }

  its(:relation) { should eq relation }

  its(:params) { should eq params }

  describe '#search' do
    context do
      let(:params) { nil }

      its(:search) { should eq relation }
    end

    context do
      let(:described_class) { Class.new ApplicationSearcher }

      its(:search) { should eq relation }
    end

    context do
      let :described_class do
        Class.new ApplicationSearcher do
          def search_by_name name; end

          def search_by_age age; end
        end
      end

      let(:conditions) { [double, double] }

      before { expect(subject).to receive(:search_by_name).with('John').and_return(conditions[0]) }

      before { expect(subject).to receive(:search_by_age).with('19').and_return(conditions[1]) }

      before { expect(conditions[0]).to receive(:merge).with(conditions[1]).and_return(:result) }

      its(:search) { should eq :result }
    end
  end

  describe '.search' do
    it do
      #
      # described_class.new(params).search
      #
      expect(described_class).to receive(:new).with(:params) do
        double.tap { |a| expect(a).to receive(:search) }
      end
    end

    after { described_class.search :params }
  end
end
