require 'rails_helper'

RSpec.describe ReceivedInvitesController, type: :controller do
  it_behaves_like :index, unauthorized: true

  describe '#collection' do
    context do
      before { subject.instance_variable_set :@collection, :collection }

      its(:collection) { should eq :collection }
    end

    context do
      before { expect(subject).to receive(:params).and_return(page: 10) }
      before do
        #
        # subject.current_user.received_invites.order(id: :desc).page(10) -> :collection
        #
        expect(subject).to receive_message_chain(:current_user, :received_invites, :order).with(id: :desc) do
          double.tap { |a| expect(a).to receive(:page).with(10).and_return(:collection) }
        end
      end

      its(:collection) { should eq :collection }
    end
  end
end
