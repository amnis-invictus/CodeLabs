class Api::Submission::FailController < Api::ApplicationController
  skip_before_action :build_resource, :authorize_resource

  def create
    head parent.fail! ? 204 : 422
  end

  private

  def parent
    @parent ||= Submission.find params[:submission_id]
  end
end
