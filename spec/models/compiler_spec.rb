require 'rails_helper'

RSpec.describe Compiler, type: :model do
  it { should validate_presence_of :name }

  it { should validate_presence_of :version }

  it { should validate_presence_of :memory_a }

  it { should validate_presence_of :memory_b }

  it { should validate_presence_of :time_a }

  it { should validate_presence_of :time_b }

  it { should validate_numericality_of :memory_a }

  it { should validate_numericality_of :memory_b }

  it { should validate_numericality_of :time_a }

  it { should validate_numericality_of :time_b }

  describe '.visible' do
    subject { described_class.visible }

    let(:expected) { described_class.where visible: true }

    its(:includes_values) { should eq expected.includes_values }

    its(:to_sql) { should eq expected.to_sql }
  end
end
