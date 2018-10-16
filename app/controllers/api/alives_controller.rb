class Api::AlivesController < Api::ApplicationController
  def create
    render :errors, status: 422 and return unless resource.save

    head 204
  end

  private

  attr_reader :resource

  def parent
    @parent ||= Worker.find params[:worker_id]
  end

  def resource_params
    params.require(:alive).permit(:status, task_status: [])
  end

  def build_resource
    @resource = Api::Alive.new parent, resource_params
  end
end
