class ContestsController < ApplicationController
  def create
    render :new and return unless resource.save

    redirect_to resource
  end

  def update
    render :edit and return unless resource.update resource_params

    redirect_to resource
  end

  def destroy
    resource.destroy

    redirect_to :contests
  end

  private

  def resource
    @resource ||= Contest.find(params[:id]).decorate
  end

  def collection
    @collection ||= Contest.includes(:owner).order(:name).page(params[:page])
  end

  def resource_params
    params.require(:contest).permit(:name, :visibility, :description, :starts_at, :ends_at)
  end

  def initialize_resource
    @resource = current_user.owned_contests.new
  end

  def build_resource
    @resource = current_user.owned_contests.new resource_params
  end
end
