require 'rails_helper'

RSpec.describe Api::SubmissionsController, type: :controller do
  it { should be_an Api::ApplicationController }

  it_behaves_like :index, format: :json

  describe '#collection' do
    context do
      before { subject.instance_variable_set :@collection, :collection }

      its(:collection) { should eq :collection }
    end

    context do
      before do
        expect(Submission).to receive_message_chain(:pending, :with_attached_source, :includes).
          with(:problem, :compiler).and_return(:collection)
      end

      its(:collection) { should eq :collection }
    end
  end
end
