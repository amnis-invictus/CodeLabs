class SubmissionsController < ApplicationController
  skip_before_action :authenticate!, only: :index

  def create
    render :new and return unless resource.save

    redirect_to resource
  end

  private
  def collection
    @collection ||= Submission.order(created_at: :desc).page(params[:page])
  end

  def parent
    @parent ||= Problem.find params[:problem_id]
  end

  def resource
    @resource ||= Submission.find params[:id]
  end

  def resource_params
    params.require(:submission).permit(:compiler_id, :source).merge(problem: parent, user: current_user)
  end

  def initialize_resource
    @resource = Submission.new
  end

  def build_resource
    @resource = Submission.new resource_params
  end
end
