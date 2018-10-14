require 'rails_helper'

RSpec.describe MembershipsController, type: :controller do
  it_behaves_like :destroy, params: { id: 1, group_id: 2 } do
    let(:group) { stub_model Group }

    let(:resource) { double group: group }

    let(:success) { -> { should redirect_to group } }
  end

  pending '#resource'

  pending '#resource_params'
end
