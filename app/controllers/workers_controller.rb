class WorkersController < ApplicationController
  private

  def collection
    @collection ||= Worker.order(alive_at: :desc).page(params[:page])
  end
end
