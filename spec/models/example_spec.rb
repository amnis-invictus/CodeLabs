require 'rails_helper'

RSpec.describe Example, type: :model do
  it { should validate_presence_of :input }

  it { should validate_presence_of :answer }
  
  it { should belong_to :problem }
end
