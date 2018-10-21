require 'rails_helper'

RSpec.describe Sharing, type: :model do
  it { should belong_to :problem }

  it { should belong_to :group }
end
