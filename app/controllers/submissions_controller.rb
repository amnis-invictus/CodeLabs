class SubmissionsController < ApplicationController
  skip_before_action :authenticate!, only: :index

  helper_method :filter

  def create
    render :new and return unless resource.save

    redirect_to resource
  end

  def destroy
    resource.destroy

    redirect_to :submissions
  end

  private

  def collection
    @collection ||= filter.submissions.includes(:compiler, :user, problem: :user).
      order(created_at: :desc).page(params[:page])
  end

  def filter
    @filter ||= SubmissionFilter.new params.permit(:contest_id, :group_id, :problem_id, :user_id)
  end

  def resource
    @resource ||= Submission.find(params[:id]).decorate
  end

  def resource_params
    params.require(:submission).permit(:compiler_id, :source).merge(user: current_user)
  end

  def build_resource
    @resource = Problem.find(params[:problem_id]).submissions.new(resource_params)
  end
end
