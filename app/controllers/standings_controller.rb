class StandingsController < ApplicationController
  private

  def resource
    @resource ||= Group.find(params[:group_id]).decorate
  end
end
