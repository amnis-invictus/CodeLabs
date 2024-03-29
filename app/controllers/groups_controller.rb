class GroupsController < ApplicationController
  def create
    resource.memberships.build user: current_user, state: :accepted, role: :owner

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
    @collection ||= Group.order(created_at: :desc).page(params[:page])
  end

  def resource_params
    params.require(:group).permit(:name, :visibility, :description, :starts_at, :ends_at)
  end

  def initialize_resource
    @resource = Group.new
  end

  def build_resource
    @resource = Group.new resource_params
  end
end
