class Api::SubmissionsController < Api::ApplicationController
  private
  def collection
    @collection ||= Submission.pending.with_attached_source.includes :problem, :compiler
  end
end
