class TestsController < ApplicationController
  skip_before_action :authorize_resource, :authenticate!, :verify_authenticity_token, :build_resource

  layout false
end
