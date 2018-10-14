class Api::AlivesController < Api::ApplicationController
  skip_before_action :authorize_resource, :build_resource, only: :create

  def create
    render :errors, status: 422 and return unless parent.update resource_params

    head 204
  end

  private

  def parent
    @parent ||= Worker.find params[:worker_id]
  end

  def resource_params
    params.require(:alive).permit(:status, task_status: []).merge(alive_at: Time.zone.now)
  end
end
