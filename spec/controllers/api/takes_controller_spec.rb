require 'rails_helper'

RSpec.describe Api::TakesController, type: :controller do
  it { should be_an Api::ApplicationController }

  pending '#create'

  describe '#parent' do
    context do
      before { subject.instance_variable_set :@parent, :parent }

      its(:parent) { should eq :parent }
    end

    context do
      before { expect(subject).to receive(:params).and_return(submission_id: 56) }

      before { expect(Submission).to receive_message_chain(:lock, :find).with(56).and_return(:parent) }

      its(:parent) { should eq :parent }
    end
  end
end
