require 'rails_helper'

RSpec.describe UserSearcher do
  let(:relation) { double }

  subject { described_class.search relation, params }

  describe '#search_by_query' do
    context do
      let(:params) { acpp query: 'John' }

      let(:sql) { 'username ILIKE :query OR name ILIKE :query' }

      before { expect(relation).to receive(:where).with(sql, query: '%John%').and_return(:result) }

      it { should eq :result }
    end

    context do
      let(:params) { acpp query: '' }

      before { expect(relation).to_not receive(:where) }

      it { should eq relation }
    end
  end
end
