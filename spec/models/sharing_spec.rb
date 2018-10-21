require 'rails_helper'

RSpec.describe Sharing, type: :model do
  pending { should validate_uniqueness_of(:problem_id).scoped_to(:group_id) }

  it { should belong_to :problem }

  it { should belong_to :group }

  it { should delegate_method(:owner).to(:group).with_prefix }

  it { should delegate_method(:user).to(:problem).with_prefix }
end
