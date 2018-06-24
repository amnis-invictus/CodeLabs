class HomeController < ApplicationController
  skip_before_action :authenticate!

  skip_before_action :authorize_resource

  skip_before_action :authorize_collection

  def show
    redirect_to :profile if current_user
  end
end
