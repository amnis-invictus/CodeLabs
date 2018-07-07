class ProblemsController < ApplicationController
  skip_before_action :authenticate!, only: %i(index show)
  skip_before_action :authorize_collection, :authorize_resource

  def index

  end

  def show

  end

  private
  def collection
    if params[:tag_id] then
      @collection ||= (Tag.find params[:tag_id]).problems.page(params[:page])
    else
      @collection ||= Problem.page(params[:page])
    end
  end

  def resource
    @resource ||= Problem.find params[:id]
  end
end
