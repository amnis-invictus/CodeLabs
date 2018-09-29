require 'rails_helper'

RSpec.describe Test, type: :model do
  it { should validate_presence_of :num }

  it { should belong_to :problem }

  pending { should have_one_attached :input }

  pending { should have_one_attached :answer }

  it { should delegate_method(:as_json).to(:decorate) }

  describe '.default_scope' do
    subject { described_class.all }

    let(:expected) { described_class.unscoped.with_attached_input.with_attached_answer }

    its(:includes_values) { should eq expected.includes_values }

    its(:to_sql) { should eq expected.to_sql }
  end
end