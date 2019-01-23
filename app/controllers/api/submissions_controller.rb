class Api::SubmissionsController < Api::ApplicationController
  skip_before_action :authorize_collection

  private

  def collection
    @collection ||= Submission.pending.with_attached_source.includes :problem, :compiler
  end
end
