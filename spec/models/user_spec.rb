require 'rails_helper'

RSpec.describe User, type: :model do
  fixtures :users

  subject { users(:one) }

  it { should validate_presence_of :email }

  it { should validate_uniqueness_of(:email).case_insensitive }

  it { should validate_presence_of :username }

  it { should validate_uniqueness_of(:username).case_insensitive }

  it { should have_one(:confirmation_request).dependent(:destroy) }

  it { should have_many(:problems).dependent(:nullify) }

  it { should have_many(:auth_tokens).dependent(:destroy) }

  it { should have_many(:submissions).dependent(:destroy) }

  it { should have_many(:owned_groups).class_name('Group').with_foreign_key(:owner_id).dependent(:destroy) }

  it { should have_many(:sent_invites).class_name('Invite').with_foreign_key(:sender_id).dependent(:destroy) }

  it { should have_many(:received_invites).class_name('Invite').with_foreign_key(:receiver_id).dependent(:destroy) }

  it { should have_and_belong_to_many :groups }

  it { should have_many(:sharings).through(:groups) }

  it { should have_many(:shared_problems).through(:sharings).source(:problem).class_name('Problem') }

  it { should have_secure_password }

  pending { should have_one_attached :avatar }

  pending { should define_bitmask_for(:roles).with_values(%i[confirmed moderator administrator]).null(false) }

  it { should delegate_method(:as_json).to(:decorate) }

  %i[confirmed moderator administrator].each do |value|
    describe "##{ value }?" do
      before { expect(subject).to receive(:roles?).with(value).and_return(:result) }

      its("#{ value }?") { should eq :result }
    end
  end
end
