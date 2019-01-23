class WorkersController < ApplicationController
  def destroy
    resource.destroy

    redirect_to :workers
  end

  private

  def resource
    @resource ||= Worker.find params[:id]
  end

  def collection
    @collection ||= Worker.order alive_at: :desc
  end
end
