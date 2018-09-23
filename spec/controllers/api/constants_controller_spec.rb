require 'rails_helper'

RSpec.describe Api::ConstantsController, type: :controller do
  it { should be_an Api::ApplicationController }

  it_behaves_like :index, unauthorized: true, format: :json

  its(:collection) { should eq Constants }
end
