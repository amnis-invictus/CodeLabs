require 'rails_helper'

RSpec.describe Api::Submission::FailController, type: :controller do
  it { should be_an Api::ApplicationController }

  describe '#create' do
    let(:parent) { double }

    before { expect(subject).to receive(:authenticate!) }

    before { allow(subject).to receive(:parent).and_return(parent) }

    context do
      before { expect(parent).to receive(:fail!).and_return(true) }

      before { post :create, params: { submission_id: 2 }, format: :json }

      it { should respond_with 204 }
    end

    context do
      before { expect(parent).to receive(:fail!).and_return(false) }

      before { post :create, params: { submission_id: 2 }, format: :json }

      it { should respond_with 422 }
    end
  end

  describe '#parent' do
    context do
      before { subject.instance_variable_set :@parent, :parent }

      its(:parent) { should eq :parent }
    end

    context do
      before { expect(subject).to receive(:params).and_return(submission_id: 56) }

      before { expect(Submission).to receive(:find).with(56).and_return(:parent) }

      its(:parent) { should eq :parent }
    end
  end
end
