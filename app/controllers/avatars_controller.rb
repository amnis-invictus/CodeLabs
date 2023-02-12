class AvatarsController < ApplicationController
  def create
    render :errors, status: :unprocessable_entity and return unless resource.save
  end

  def destroy
    resource.destroy

    head :no_content
  end

  private

  def resource
    @resource ||= build_resource
  end

  def resource_params
    params.require(:avatar).permit(:file).merge(user: current_user)
  end

  def build_resource
    @resource = Avatar.new resource_params
  end
end
