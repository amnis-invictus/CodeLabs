require 'rails_helper'

RSpec.describe ConfirmationRequest, type: :model do
  it { should belong_to :user }

  it { should define_enum_for(:status).with_values(pending: 0, accepted: 1, rejected: 2) }

  it { should delegate_method(:name).to(:user).with_prefix }

  it { should delegate_method(:username).to(:user).with_prefix }
end
