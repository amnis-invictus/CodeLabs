class Api::SubmissionsController < Api::ApplicationController
  private
  def collection
    @collection ||= Submission.pending.with_attached_source
  end
end
