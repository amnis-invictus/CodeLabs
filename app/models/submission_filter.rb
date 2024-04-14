class SubmissionFilter
  extend ActiveModel::Naming

  with_options prefix: true, allow_nil: true do
    delegate :id, :name, to: :contest
    delegate :id, :name, to: :group
    delegate :id, :caption, to: :problem
    delegate :id, :name, to: :user
  end

  def initialize params
    @params = params
  end

  def submissions
    SubmissionSearcher.search Submission.all, contest:, group:, problem:, user:
  end

  def applied? param
    @params["#{ param }_id"].present?
  end

  def contest
    @contest ||= (Contest.find @params[:contest_id] if @params[:contest_id].present?)
  end

  def group
    @group ||= (Group.find @params[:group_id] if @params[:group_id].present?)
  end

  def problem
    @problem ||= (Problem.find @params[:problem_id] if @params[:problem_id].present?)
  end

  def user
    @user ||= (User.find(@params[:user_id]).decorate if @params[:user_id].present?)
  end
end
