require 'rails_helper'

RSpec.describe Log, type: :model do
  it { should validate_presence_of :data }

  it { should define_enum_for(:type).with(source: 0, checker: 1) }

  it { should belong_to :submission }

  it { expect(described_class.inheritance_column).to eq '' }
end
