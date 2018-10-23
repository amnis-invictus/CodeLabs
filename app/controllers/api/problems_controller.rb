class Api::ProblemsController < Api::ApplicationController
  skip_before_action :authorize_collection, :authorize_resource

  private
  def resource
    @resource ||= Problem.find params[:id]
  end
end
