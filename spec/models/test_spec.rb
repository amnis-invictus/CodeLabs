require 'rails_helper'

RSpec.describe Test, type: :model do
  it { should validate_presence_of :num }

  it { should validate_presence_of :point }

  it { should validate_numericality_of(:point).only_integer }

  pending { should validate_uniqueness_of(:num).scoped_to(:problem_id) }

  it { should belong_to(:problem).touch }

  it { should have_one :input_attachment }

  it { should have_one :answer_attachment }

  it { should have_many(:results).dependent(:nullify) }

  it { should delegate_method(:as_json).to(:decorate) }

  describe '.default_scope' do
    subject { described_class.all }

    let(:expected) { described_class.unscoped.with_attached_input.with_attached_answer.order :num }

    its(:includes_values) { should eq expected.includes_values }

    its(:to_sql) { should eq expected.to_sql }
  end
end
