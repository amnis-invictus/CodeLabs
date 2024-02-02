class StandingsController < ApplicationController
  private

  def resource
    @resource ||= Contest.find(params[:contest_id]).decorate
  end
end
