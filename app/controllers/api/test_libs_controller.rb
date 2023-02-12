class Api::TestLibsController < Api::ApplicationController
  skip_before_action :authorize_resource

  skip_before_action :authenticate!, only: :show

  def create
    render :errors, status: :unprocessable_entity and return unless resource.save

    head :no_content
  end

  private

  def resource
    return @resource if defined? @resource

    if params[:version] == 'latest'
      @resource = TestLib.order(version: :desc).first!
    else
      @resource = TestLib.find_by! version: VersionAdapter.string_to_array(params[:version])
    end
  end

  def resource_params
    params.require(:test_lib).permit(:version, :binary)
  end

  def build_resource
    version, binary = resource_params.values_at :version, :binary

    @resource = TestLib.new version: VersionAdapter.string_to_array(version), binary: binary
  end
end
