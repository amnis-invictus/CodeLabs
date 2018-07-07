class ProblemsController < ApplicationController
  skip_before_action :authenticate!, only: %i(index show)

  skip_before_action :authorize_collection, :authorize_resource

  private
  def collection
    @collection ||= (parent&.problems || Problem.all).page(params[:page])
  end

  def parent
    @parent ||= Tag.find params[:tag_id] if params[:tag_id]
  end

  def resource
    @resource ||= Problem.find params[:id]
  end
end
