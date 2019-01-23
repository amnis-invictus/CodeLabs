class Api::WorkersController < Api::ApplicationController
  skip_before_action :authorize_resource, only: :create

  def create
    render :errors, status: 422 and return unless resource.save
  end

  private

  attr_reader :resource

  def resource_params
    params.require(:worker).permit(:name, :api_version, :api_type, :webhook_supported, :status, ips: []).merge(alive_at: Time.zone.now)
  end

  def build_resource
    @resource = Worker.new resource_params
  end
end
