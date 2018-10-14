require 'rails_helper'

RSpec.describe UserSearcher do
  let(:relation) { double }

  subject { UserSearcher.search relation, params }

  describe '#search_by_username' do
    context do
      let(:params) { acp username: 'John' }

      before { expect(relation).to receive(:where).with('username ILIKE ?', '%John%').and_return(:result) }

      it { should eq :result }
    end

    context do
      let(:params) { acp username: '' }

      before { expect(relation).to_not receive(:where) }

      it { should eq relation }
    end
  end
end
