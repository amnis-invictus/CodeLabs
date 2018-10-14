class Api::SessionsController < Api::ApplicationController
  skip_before_action :authorize_resource, :build_resource, only: %i(create destroy)

  def create
    render :errors, status: 422 and return unless resource.update alive_at: Time.zone.now, status: :ok

    head 204
  end

  def destroy
    render :errors, status: 422 and return unless resource.update alive_at: Time.zone.now, status: :disabled, task_status: []

    head 204
  end

  private

  def resource
    @resource ||= Worker.find params[:worker_id]
  end
end
