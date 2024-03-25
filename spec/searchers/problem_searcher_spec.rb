require 'rails_helper'

RSpec.describe ProblemSearcher do
  let(:relation) { Problem.all }

  subject { described_class.search relation, params }

  describe '#search_by_user_id' do
    let(:params) { acpp user_id: 1 }

    it { should eq Problem.where(user_id: 1) }
  end

  describe '#search_by_tag_id' do
    let(:params) { acpp tag_id: 1 }

    it { should eq Problem.joins(:problems_tags).where(problems_tags: { tag_id: 1 }) }
  end

  describe '#search_by_contest_id' do
    let(:params) { acpp contest_id: 1 }

    it { should eq Problem.joins(:sharings).where(sharings: { contest_id: 1 }) }
  end

  describe '#search_by_query' do
    let(:params) { acpp query: 'test' }

    let(:by_translation) { ProblemTranslation.where('caption ILIKE ?', '%test%').select(:problem_id) }

    it { should eq Problem.where(id: by_translation) }
  end
end
