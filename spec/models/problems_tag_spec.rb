require 'rails_helper'

RSpec.describe ProblemsTag, type: :model do
  it { should belong_to :problem }

  it { should belong_to(:tag).counter_cache(:problems_count) }
end
