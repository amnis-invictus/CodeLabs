require 'rails_helper'

RSpec.describe Problem, type: :model do
  it { should validate_presence_of :memory_limit }

  it { should validate_presence_of :time_limit }

  it { should validate_presence_of :real_time_limit }

  it { should validate_numericality_of :memory_limit }

  it { should validate_numericality_of :time_limit }

  it { should validate_numericality_of :real_time_limit }

  it { should_not allow_value(nil).for(:private) }

  it { should allow_value(true).for(:private) }

  it { should allow_value(false).for(:private) }

  it { should belong_to(:user).optional }

  it { should belong_to(:checker_compiler).class_name('Compiler') }

  pending { should have_one_attached :checker_source }

  it { should have_one(:translation).conditions(language: I18n.locale).class_name('ProblemTranslation') }

  it { should have_one(:default_translation).conditions(default: true).class_name('ProblemTranslation') }

  it { should have_many(:translations).dependent(:destroy).class_name('ProblemTranslation') }

  it { should have_many(:tests).dependent(:destroy) }

  it { should have_many(:examples).dependent(:destroy) }

  it { should have_many(:submissions).dependent(:destroy) }

  it { should have_many(:sharings).dependent(:destroy) }

  it { should have_many(:groups).through(:sharings) }

  it { should have_and_belong_to_many :tags }

  it { should delegate_method(:as_json).to(:decorate) }

  describe '.default_scope' do
    subject { described_class.all }

    let(:expected) { described_class.unscoped.includes :translation, :default_translation }

    its(:includes_values) { should eq expected.includes_values }

    its(:to_sql) { should eq expected.to_sql }
  end
end
