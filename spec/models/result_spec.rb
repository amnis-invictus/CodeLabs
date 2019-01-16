require 'rails_helper'

RSpec.describe Result, type: :model do
  it { should validate_presence_of :status }

  it { should validate_presence_of :memory }

  it { should validate_presence_of :time }

  it { should validate_numericality_of :memory }

  it { should validate_numericality_of :time }

  it { should validate_presence_of(:test).on(:create) }

  it do
    should define_enum_for(:status).with_values \
      ok: 0,
      wrong_answer: 1,
      presentation_error: 2,
      dirt: 4,
      points: 5,
      bad_test: 6,
      unexpected_eof: 8,
      runtime_error: 10,
      memory_limit_exceded: 14,
      time_limit_exceded: 15,
      partilly_correct: 16
  end

  it { should belong_to :submission }

  it { should belong_to(:test).optional }

  it { should delegate_method(:num).to(:test).with_prefix.allow_nil }
end
