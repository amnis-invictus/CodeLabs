require 'rails_helper'

RSpec.describe GroupDecorator do
  let(:owner) { stub_model User }

  let(:resource) { stub_model Group, visibility: :moderated, owner: owner }

  subject { resource.decorate }

  its(:owner) { should be_a UserDecorator }

  its(:accepted_users) { should be_a Draper::CollectionDecorator }

  it { should delegate_method(:name).to(:owner).with_prefix }

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
end
