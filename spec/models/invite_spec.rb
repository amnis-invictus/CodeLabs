require 'rails_helper'

RSpec.describe Invite, type: :model do
  it { should belong_to :group }

  it { should belong_to(:sender).class_name('User') }

  it { should belong_to(:receiver).class_name('User') }
end
