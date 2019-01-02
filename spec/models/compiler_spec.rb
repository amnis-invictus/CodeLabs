require 'rails_helper'

RSpec.describe Compiler, type: :model do
  it { should validate_presence_of :name }

  it { should validate_presence_of :version }

  it { should validate_presence_of :status }

  it { should validate_presence_of :memory_a }

  it { should validate_presence_of :memory_b }

  it { should validate_presence_of :time_a }

  it { should validate_presence_of :time_b }

  it { should validate_numericality_of :memory_a }

  it { should validate_numericality_of :memory_b }

  it { should validate_numericality_of :time_a }

  it { should validate_numericality_of :time_b }

  it { should define_enum_for(:status).with_values(in_test: 0, reserved: 1, public: 2).with_prefix }
end
