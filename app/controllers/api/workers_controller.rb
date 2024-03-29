class Api::WorkersController < Api::ApplicationController
  def create
    render :errors, status: :unprocessable_entity and return unless resource.save
  end

  def update
    render :errors, status: :unprocessable_entity and return unless resource.update resource_params

    head :no_content
  end

  private

  def resource
    @resource ||= Worker.find params[:id]
  end

  def resource_params
    params.require(:worker).permit \
      :alive_at,
      :api_type,
      :api_version,
      :name,
      :status,
      :version,
      :webhook_supported,
      ips: [],
      task_status: [],
      active_compilers: [],
      ignored_compilers: []
  end

  def build_resource
    @resource = Worker.new resource_params
  end
end
