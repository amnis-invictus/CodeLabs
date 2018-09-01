class ProblemsController < ApplicationController
  skip_before_action :authenticate!, only: %i(index show)

  helper_method :channel_id

  def create
    name = File.join Dir.tmpdir, SecureRandom.uuid

    FileUtils.copy params[:problem][:archive].path, name

    ProcessProblemArchiveJob.perform_later name, channel_id

    head 204
  end

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

  def initialize_resource
    @resource = Problem.new
  end

  def channel_id
    @channel_id ||= params.dig(:problem, :channel_id) || SecureRandom.uuid
  end

  alias_method :build_resource, :initialize_resource
end
