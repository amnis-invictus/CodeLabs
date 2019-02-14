require 'rails_helper'

RSpec.describe Membership, type: :model do
  it { should validate_presence_of :state }

  pending { should validate_uniqueness_of(:user).scoped_to(:group) }

  it { should belong_to(:user).required }

  it { should belong_to(:group).required }

  it { should define_enum_for(:state).with_values(%i[requested invited accepted]).with_prefix }
end
