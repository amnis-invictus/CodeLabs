class Api::ReleasesController < Api::ApplicationController
  skip_before_action :build_resource

  def create
    head parent.release! ? 204 : 422
  end

  private
  def parent
    @parent ||= Submission.find params[:submission_id]
  end
end