class Api::TestRequestsController < Api::ApplicationController
  private
  def collection
    @collection ||= TestRequest.includes(:problem, :solution).page(params[:page])
  end
end
