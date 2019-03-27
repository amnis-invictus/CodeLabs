class Submission::RetestsController < ApplicationController
  def create
    flash[:error] = I18n.t 'flash.save.failure' unless resource.save

    redirect_back fallback_location: :submission, allow_other_host: false
  end

  private

  attr_reader :resource

  def parent
    @parent ||= Submission.find params[:submission_id]
  end

  def build_resource
    @resource = Submission::Retest.new parent
  end
end
