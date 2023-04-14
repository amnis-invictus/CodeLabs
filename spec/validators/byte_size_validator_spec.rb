require 'rails_helper'

ByteSizeValidator::Validatable = Struct.new :source do
  include ActiveModel::Validations

  validates :source, byte_size: { maximum: 1.kilobytes }
end

RSpec.describe ByteSizeValidator do
  subject { ByteSizeValidator::Validatable.new source }

  before { subject.valid? }

  context do
    let(:source) { double attached?: false }

    its(:errors) { should be_empty }
  end

  context do
    let(:source) { double attached?: true, byte_size: 1.kilobytes }

    its(:errors) { should be_empty }
  end

  context do
    let(:source) { double attached?: true, byte_size: 2.kilobytes }

    its(:errors) { should_not be_empty }

    its('errors.details.to_h') { should eq source: [{ count: 1024, error: :too_long }] }
  end
end
