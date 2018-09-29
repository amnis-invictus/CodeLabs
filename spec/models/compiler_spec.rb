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
end
