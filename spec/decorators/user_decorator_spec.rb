require 'rails_helper'

RSpec.describe UserDecorator do
  fixtures :users

  let(:resource) { users(:one) }

  subject { resource.decorate }

  its(:search_suggestion) { should eq '<div><p class="mb-0">User One</p><small class="text-muted">user-one</small></div>' }

  describe '#as_json' do
    before { expect(subject).to receive(:search_suggestion).and_return(:search_suggestion) }

    its(:as_json) { should eq id: resource.id, name: 'User One', search_suggestion: :search_suggestion }
  end

  describe '#name' do
    its(:name) { should eq 'User One' }

    context do
      let(:resource) { stub_model User, username: 'kostyanf14' }

      its(:name) { should eq 'kostyanf14' }
    end
  end
end
