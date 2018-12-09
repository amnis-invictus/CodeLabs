require 'rails_helper'

RSpec.describe Tag, type: :model do
  it { should have_one(:translation).conditions(language: I18n.locale).class_name('TagTranslation') }

  it { should have_many(:translations).dependent(:destroy).class_name('TagTranslation') }

  it { should have_many(:problems_tags).dependent(:destroy) }

  it { should have_many(:problems).through(:problems_tags) }

  it { should delegate_method(:name).to(:translation) }

  describe '.default_scope' do
    subject { described_class.all }

    let(:expected) { described_class.unscoped.includes :translation }

    its(:includes_values) { should eq expected.includes_values }

    its(:to_sql) { should eq expected.to_sql }
  end
end
