class ProblemsController < ApplicationController
  skip_before_action :authenticate!, only: %i(index show)
  skip_before_action :authorize_collection, :authorize_resource

  def index

  end

  def show

  end

  private
  def collection
    @collection ||= Problem.page(params[:page])
  end

  def resource
    @resource ||= Problem.find params[:id]
  end
end
