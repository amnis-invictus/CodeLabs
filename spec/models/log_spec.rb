require 'rails_helper'

RSpec.describe Log, type: :model do
  it { expect(described_class.inheritance_column).to eq '' }

  it { should validate_presence_of :data }

  it { should define_enum_for(:type).with_values(source: 0, checker: 1) }

  it { should belong_to :submission }
end
