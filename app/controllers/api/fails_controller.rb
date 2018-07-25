class Api::FailsController < Api::ApplicationController
  skip_before_action :build_resource

  def create
    parent.fails_count += 1

    head parent.fail! ? 204 : 422
  end

  private
  def parent
    @parent ||= Submission.find params[:submission_id]
  end
end
