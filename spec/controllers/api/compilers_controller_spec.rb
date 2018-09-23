require 'rails_helper'

RSpec.describe Api::CompilersController, type: :controller do
  it { should be_an Api::ApplicationController }

  it_behaves_like :index, unauthorized: true, format: :json

  describe '#collection' do
    context do
      before { subject.instance_variable_set :@collection, :collection }

      its(:collection) { should eq :collection }
    end

    context do
      before { expect(Compiler).to receive(:all).and_return(:collection) }

      its(:collection) { should eq :collection }
    end
  end
end
