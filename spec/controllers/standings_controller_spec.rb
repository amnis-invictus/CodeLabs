require 'rails_helper'

RSpec.describe StandingsController, type: :controller do
  it_behaves_like :show, params: { group_id: 1 }

  describe '#resource' do
    context do
      before { subject.instance_variable_set :@resource, :resource }

      its(:resource) { should eq :resource }
    end

    context do
      before { expect(subject).to receive(:params).and_return(group_id: 49) }

      before do
        #
        # Group.find(49).decorate -> :resource
        #
        expect(Group).to receive(:find).with(49) do
          double.tap { |a| expect(a).to receive(:decorate).and_return(:resource) }
        end
      end

      its(:resource) { should eq :resource }
    end
  end
end
