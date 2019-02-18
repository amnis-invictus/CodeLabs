require 'rails_helper'

RSpec.describe User, type: :model do
  fixtures :users

  subject { users(:one) }

  it { should validate_presence_of :email }

  it { should validate_uniqueness_of(:email).case_insensitive }

  it { should validate_presence_of :username }

  it { should validate_uniqueness_of(:username).case_insensitive }

  it { should have_one :avatar_attachment }

  it { should have_one(:confirmation_request).dependent(:destroy) }

  it { should have_many(:problems).dependent(:nullify) }

  it { should have_many(:auth_tokens).dependent(:destroy) }

  it { should have_many(:submissions).dependent(:destroy) }

  it { should have_many(:owned_groups).class_name('Group').with_foreign_key(:owner_id).dependent(:destroy) }

  it { should have_many(:pending_memberships).class_name('Membership').dependent(:destroy) }

  it { should have_many(:accepted_memberships).conditions(state: :accepted).class_name('Membership').dependent(:destroy) }

  it { should have_many(:pending_groups).through(:pending_memberships).source(:group).class_name('Group') }

  it { should have_many(:accepted_groups).through(:accepted_memberships).source(:group).class_name('Group') }

  it { should have_many(:sharings).through(:accepted_groups) }

  it { should have_many(:shared_problems).through(:sharings).source(:problem).class_name('Problem') }

  it { should have_secure_password }

  it { should allow_values(%i[confirmed moderator administrator]).for(:roles) }

  it { should delegate_method(:as_json).to(:decorate) }

  %i[confirmed moderator administrator].each do |value|
    describe "##{ value }?" do
      before { expect(subject).to receive(:roles?).with(value).and_return(:result) }

      its("#{ value }?") { should eq :result }
    end
  end
end
