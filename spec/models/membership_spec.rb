require 'rails_helper'

RSpec.describe Membership, type: :model do
  it { should validate_presence_of :state }

  # TODO: FIX ME!
  # pending { should validate_uniqueness_of(:user).scoped_to(:membershipable_id, :membershipable_type) }

  it { should belong_to(:user).required }

  it { should belong_to(:membershipable).required }

  it { should define_enum_for(:state).with_values(%i[requested invited accepted]).with_prefix }
end
