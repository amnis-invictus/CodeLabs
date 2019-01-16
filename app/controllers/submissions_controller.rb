class SubmissionsController < ApplicationController
  skip_before_action :authenticate!, only: :index

  def create
    render :new and return unless resource.save

    redirect_to resource
  end

  private

  def collection
    @collection ||= submissions.includes(:compiler, :user, problem: :user).order(created_at: :desc).page(params[:page])
  end

  def submissions
    parent ? parent.submissions : Submission.all
  end

  def parent
    @parent ||= \
      case
      when params[:group_id]
        Group.find params[:group_id]
      when params[:problem_id]
        Problem.find params[:problem_id]
      when params[:user_id]
        User.find params[:user_id]
      end
  end

  def resource
    @resource ||= Submission.find(params[:id]).decorate
  end

  def resource_params
    params.require(:submission).permit(:compiler_id, :source).merge(user: current_user)
  end

  def build_resource
    @resource = parent.submissions.new resource_params
  end
end
