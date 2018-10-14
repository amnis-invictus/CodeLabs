class Api::SessionsController < Api::ApplicationController
  skip_before_action :authorize_resource, :build_resource, only: %i(create destroy)

  def create
    render :errors, status: 422 and return unless parent.update alive_at: Time.zone.now, status: :ok

    head 204
  end

  def destroy
    render :errors, status: 422 and return unless parent.update alive_at: Time.zone.now, status: :disabled

    head 204
  end

  private

  def parent
    @parent ||= Worker.find params[:worker_id]
  end
end
