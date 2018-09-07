class Api::ReleasesController < Api::ApplicationController
  def create
    head resource.save ? 204 : 422
  end

  private
  attr_reader :resource

  def resource_params
    params.require(:release).permit(:test_result)
  end

  def parent
    @parent ||= Submission.find params[:submission_id]
  end

  def build_resource
    @resource = Release.new parent, resource_params
  end
end
