class Api::ResultsController < Api::ApplicationController
  def create
    render :errors, status: :unprocessable_entity and return unless resource.save

    head :no_content
  end

  private

  attr_reader :resource

  def resource_params
    params.require(:result).permit(:status, :log, :memory, :time, :test_id, :submission_id)
  end

  def build_resource
    @resource = Result.new resource_params
  end
end
