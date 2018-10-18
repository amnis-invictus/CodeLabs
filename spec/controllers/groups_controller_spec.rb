require 'rails_helper'

RSpec.describe GroupsController, type: :controller do
  it_behaves_like :index

  it_behaves_like :show

  it_behaves_like :new

  it_behaves_like :edit

  it_behaves_like :create do
    let(:resource) { stub_model Group }

    let(:success) { -> { should redirect_to resource } }

    let(:failure) { -> { should render_template :new } }
  end

  it_behaves_like :update do
    let(:resource) { stub_model Group }

    let(:success) { -> { should redirect_to resource } }

    let(:failure) { -> { should render_template :edit } }
  end

  it_behaves_like :destroy do
    let(:resource) { stub_model Group }

    let(:success) { -> { should redirect_to :groups } }
  end

  pending '#resource'

  pending '#collection'

  pending '#resource_params'

  pending '#initialize_resource'

  pending '#build_resource'
end
