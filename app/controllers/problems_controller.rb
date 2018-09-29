class ProblemsController < ApplicationController
  skip_before_action :authenticate!, only: %i(index show)

  skip_before_action :authorize_resource, only: :'new-online'

  helper_method :channel_id

  #
  # TODO: refactor, move to service class
  #
  def create
    name = File.join Dir.tmpdir, SecureRandom.uuid

    FileUtils.copy params[:problem][:archive].path, name

    ProcessProblemArchiveJob.perform_later current_user, name, channel_id

    head 204
  end

  private
  def collection
    @collection ||= (parent&.problems || Problem.all).order(:id).page(params[:page])
  end

  def parent
    @parent ||= Tag.find params[:tag_id] if params[:tag_id]
  end

  def resource
    @resource ||= Problem.find(params[:id]).decorate
  end

  def initialize_resource
    @resource = Problem.new
  end

  def channel_id
    @channel_id ||= params.dig(:problem, :channel_id) || SecureRandom.uuid
  end

  alias_method :build_resource, :initialize_resource
end
