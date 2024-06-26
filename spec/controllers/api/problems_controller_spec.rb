require 'rails_helper'

RSpec.describe Api::ProblemsController, type: :controller do
  it { should be_an Api::ApplicationController }

  it_behaves_like :show, format: :json, unauthorized: true

  describe '#resource' do
    context do
      before { subject.instance_variable_set :@resource, :resource }

      its(:resource) { should eq :resource }
    end

    context do
      let(:problem) { stub_model Problem }

      before { expect(subject).to receive(:params).and_return(id: 52) }

      before { expect(Problem).to receive(:find).with(52).and_return(problem) }

      its(:resource) { should eq problem }

      its(:resource) { should be_decorated_with ProblemDecorator }

      its('resource.context') { should eq :api }
    end
  end
end
