class Api::ResultsController < Api::ApplicationController
  def create
    render :errors, status: 422 unless resource.save

    head 204
  end

  private
  attr_reader :resource

  def resource_params
    params.require(:result).permit(:status, :log, :test_id, :submission_id)
  end

  def build_resource
    @resource = ResultFactory.build resource_params
  end
end
