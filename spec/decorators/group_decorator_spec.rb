require 'rails_helper'

RSpec.describe GroupDecorator do
  let(:owner) { stub_model User }

  let(:resource) { stub_model Group, visibility: :moderated, owner: owner }

  subject { resource.decorate }

  its(:owner) { should be_a UserDecorator }

  its(:accepted_users) { should be_a Draper::CollectionDecorator }

  its(:problems) { should be_a Draper::CollectionDecorator }

  it { should delegate_method(:name).to(:owner).with_prefix }

  it { should delegate_method(:state_requested?).to(:current_user_membership).with_prefix.allow_nil }

  it { should delegate_method(:state_invited?).to(:current_user_membership).with_prefix.allow_nil }

  it { should delegate_method(:state_accepted?).to(:current_user_membership).with_prefix.allow_nil }

  describe '#visibility_icon' do
    before { expect(subject).to receive(:visibility_icon_class).and_return('visibility_icon_class') }

    its :visibility_icon do
      should eq '<i class="visibility_icon_class" title="Moderated" data-toggle="tooltip" data-placement="bottom"></i>'
    end
  end

  describe '#visibility_icon_class' do
    its(:visibility_icon_class) { should eq 'mr-3 fas fa-lock' }

    context do
      let(:resource) { stub_model Group, visibility: :private }

      its(:visibility_icon_class) { should eq 'mr-3 fas fa-lock' }
    end

    context do
      let(:resource) { stub_model Group, visibility: :public }

      its(:visibility_icon_class) { should eq 'mr-3 fas fa-unlock' }
    end
  end

  describe '#current_user_membership' do
    before { allow(subject).to receive_message_chain(:h, :current_user).and_return(current_user) }

    context do
      let(:current_user) { nil }

      before { expect(resource).to_not receive(:memberships) }

      its(:current_user_membership) { should be_nil }
    end

    context do
      let(:current_user) { stub_model User }

      before do
        expect(resource).to \
          receive_message_chain(:memberships, :find_by).with(user: current_user).and_return(:current_user_membership)
      end

      its(:current_user_membership) { should eq :current_user_membership }
    end

    context do
      let(:current_user) { stub_model User }

      before { subject.instance_variable_set :@current_user_membership, :current_user_membership }

      before { expect(resource).to_not receive(:memberships) }

      its(:current_user_membership) { should eq :current_user_membership }
    end
  end
end
