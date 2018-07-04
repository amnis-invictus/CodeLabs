class Api::SubmissionsController < Api::ApplicationController
  private
  def collection
    @collection ||= Submission.with_attached_source.page(params[:page])
  end
end
