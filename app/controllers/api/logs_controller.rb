class Api::LogsController < Api::ApplicationController
  def create
    render :errors, status: 422 and return unless resource.save

    head 204
  end

  private

  attr_reader :resource

  def parent
    @parent ||= Submission.find params[:submission_id]
  end

  def resource_params
    params.require(:log).permit(:data, :type)
  end

  def build_resource
    @resource = parent.logs.new resource_params
  end
end
