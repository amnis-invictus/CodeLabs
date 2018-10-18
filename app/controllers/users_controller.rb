class UsersController < ApplicationController
  skip_before_action :authenticate!, only: %i(new create)

  skip_before_action :authorize_resource, only: :confirm

  def create
    render :new and return unless resource.save

    redirect_to %i(new session)
  end

  private
  attr_reader :resource

  def collection
    @collection ||= UserSearcher.search(User, params).page(params[:page])
  end

  def resource_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end

  def initialize_resource
    @resource = User.new
  end

  def build_resource
    @resource = User.new resource_params
  end
end
