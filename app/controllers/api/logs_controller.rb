class Api::LogsController < Api::ApplicationController
  def create
    render :errors, status: :unprocessable_entity and return unless resource.save

    head :no_content
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
