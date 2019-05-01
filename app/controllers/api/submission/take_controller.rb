class Api::Submission::TakeController < Api::ApplicationController
  skip_before_action :build_resource, :authorize_resource

  around_action :wrap_in_transaction, only: :create

  def create
    head parent.take! ? 204 : 422
  end

  private

  def parent
    @parent ||= Submission.lock.find params[:submission_id]
  end

  def wrap_in_transaction
    ActiveRecord::Base.transaction { yield }
  end
end
