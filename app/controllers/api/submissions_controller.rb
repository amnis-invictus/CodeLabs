class Api::SubmissionsController < Api::ApplicationController
  private
  def collection
    @collection ||= Submission.includes(:problem, :solution).page(params[:page])
  end
end
