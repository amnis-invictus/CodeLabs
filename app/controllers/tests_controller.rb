class TestsController < ApplicationController
  skip_before_action :authorize_resource, :authenticate!

  layout false
end
