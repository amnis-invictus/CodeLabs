require 'rails_helper'

RSpec.describe User, type: :model do
  fixtures :users

  subject { users(:one) }

  it { should validate_presence_of :email }

  it { should validate_uniqueness_of(:email).case_insensitive }

  it { should validate_presence_of :username }

  it { should validate_uniqueness_of(:username).case_insensitive }

  it { should have_many(:auth_tokens).dependent(:destroy) }

  it { should have_many(:submissions).dependent(:destroy) }

  it { should have_many(:owned_groups).class_name('Group').with_foreign_key(:owner_id) }

  it { should have_many(:sent_invites).class_name('Invite').with_foreign_key(:sender_id) }

  it { should have_many(:received_invites).class_name('Invite').with_foreign_key(:receiver_id) }

  it { should have_and_belong_to_many :groups }

  it { should have_secure_password }

  pending { should have_one_attached :avatar }

  it { should delegate_method(:as_json).to(:decorate) }
end
