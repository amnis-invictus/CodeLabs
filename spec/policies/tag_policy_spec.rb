require 'rails_helper'

RSpec.describe TagPolicy do
  subject { described_class }

  permissions :index? do
    it { should permit nil, double }
  end
end
