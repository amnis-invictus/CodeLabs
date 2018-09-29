class ArchivesController < ApplicationController
  def create
    render :new and return unless resource.save

    head 204
  end

  private
  attr_reader :resource

  def resource_params
    params.require(:archive).permit(:file, :channel_id).merge(user: current_user)
  end

  def initialize_resource
    @resource = Archive.new channel_id: SecureRandom.uuid
  end

  def build_resource
    @resource = Archive.new resource_params
  end
end
