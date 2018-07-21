class HomeController < ApplicationController
  skip_before_action :authenticate!, :authorize_resource

  def show
    redirect_to :profile if current_user
  end
end
