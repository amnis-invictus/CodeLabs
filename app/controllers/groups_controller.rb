class GroupsController < ApplicationController
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

    redirect_to :groups
  end

  private

  def resource
    @resource ||= Group.find(params[:id]).decorate
  end

  def collection
    @collection ||= Group.includes(:owner).order(:name).page(params[:page])
  end

  def resource_params
    params.require(:group).permit(:name, :visibility, :description, :starts_at, :ends_at)
  end

  def initialize_resource
    @resource = current_user.owned_groups.new
  end

  def build_resource
    @resource = current_user.owned_groups.new resource_params
  end
end
