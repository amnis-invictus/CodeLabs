require 'rails_helper'

RSpec.describe TestLib, type: :model do
  subject { described_class.new version: [1, 0, 7_784, 34_987] }

  it { should validate_presence_of :version }

  it { should validate_uniqueness_of :version }

  it { should validate_presence_of :binary }

  it { should have_one_attached :binary }

  it { should delegate_method(:as_json).to(:decorate) }
end
