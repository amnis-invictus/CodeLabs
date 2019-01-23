require 'rails_helper'

RSpec.describe WorkersController, type: :controller do
  it_behaves_like :index

  it_behaves_like :destroy do
    let(:success) { -> { should redirect_to :workers } }
  end

  describe '#resource' do
    context do
      before { subject.instance_variable_set :@resource, :resource }

      its(:resource) { should eq :resource }
    end

    context do
      before { expect(subject).to receive(:params).and_return(id: 324) }

      before { expect(Worker).to receive(:find).with(324).and_return(:resource) }

      its(:resource) { should eq :resource }
    end
  end

  describe '#collection' do
    context do
      before { subject.instance_variable_set :@collection, :collection }

      its(:collection) { should eq :collection }
    end

    context do
      before { expect(Worker).to receive(:order).with(alive_at: :desc).and_return(:collection) }

      its(:collection) { should eq :collection }
    end
  end
end
