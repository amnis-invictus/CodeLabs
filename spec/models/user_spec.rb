require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of :email }

  it { should validate_uniqueness_of(:email).case_insensitive }

  it { should have_many(:auth_tokens).dependent(:destroy) }

  pending { should have_one_attached :avatar }

  it { should have_secure_password }
end
