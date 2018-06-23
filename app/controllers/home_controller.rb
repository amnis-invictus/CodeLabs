class HomeController < ApplicationController
  skip_before_action :authenticate!

  skip_before_action :authorize_resource

  skip_before_action :authorize_collection
end
