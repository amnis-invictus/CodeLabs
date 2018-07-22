class Api::ProblemsController < Api::ApplicationController
  private
  def resource
    @resource ||= Problem.find params[:id]
  end
end
