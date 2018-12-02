require 'rails_helper'

RSpec.describe TagsController, type: :controller do
  it_behaves_like :index, anonymous: true

  it_behaves_like :index, anonymous: true, format: :json

  describe '#collection' do
    context do
      before { subject.instance_variable_set :@collection , :collection }

      its(:collection) { should eq :collection }
    end

    context do
      before { expect(Tag).to receive(:all).and_return(:collection) }

      its(:collection) { should eq :collection }
    end
  end
end
