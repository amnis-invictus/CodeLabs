class Api::TakesController < Api::ApplicationController
  skip_before_action :build_resource, :authorize_resource
  
  #
  # TODO: refactor, move to service class
  #
  def create
    head parent.take! ? 204 : 422
  end

  private
  def parent
    @parent ||= Submission.lock.find params[:submission_id]
  end
end
