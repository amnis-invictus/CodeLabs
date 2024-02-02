require 'rails_helper'

RSpec.describe StandingsController, type: :controller do
  it_behaves_like :show, params: { contest_id: 1 }

  describe '#resource' do
    context do
      before { subject.instance_variable_set :@resource, :resource }

      its(:resource) { should eq :resource }
    end

    context do
      before { expect(subject).to receive(:params).and_return(contest_id: 49) }

      before do
        #
        # Contest.find(49).decorate -> :resource
        #
        expect(Contest).to receive(:find).with(49) do
          double.tap { |a| expect(a).to receive(:decorate).and_return(:resource) }
        end
      end

      its(:resource) { should eq :resource }
    end
  end
end
