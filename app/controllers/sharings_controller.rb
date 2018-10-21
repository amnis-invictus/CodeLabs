class SharingsController < ApplicationController
  def create
    render :new and return unless resource.save

    redirect_to parent
  end

  private

  attr_reader :resource

  def parent
    @parent ||= Group.find params[:group_id]
  end

  def resource_params
    params.require(:sharing).permit(:problem_id).merge(group: parent)
  end

  def initialize_resource
    @resource = Sharing.new group: parent
  end

  def build_resource
    @resource = Sharing.new resource_params
  end
end
