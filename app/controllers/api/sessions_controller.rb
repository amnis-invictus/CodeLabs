class Api::SessionsController < Api::ApplicationController
  def create
    render :errors, status: 422 and return unless resource.save

    head 204
  end

  def destroy
    render :errors, status: 422 and return unless resource.destroy

    head 204
  end

  private

  def resource
    @resource ||= build_resource
  end

  def parent
    @parent ||= ::Worker.find params[:worker_id]
  end

  def build_resource
    @resource = Api::Worker::Session.new parent
  end
end
