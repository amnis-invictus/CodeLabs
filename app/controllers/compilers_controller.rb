class CompilersController < ApplicationController
  def create
    redirect_to resource and return if resource.save

    flash.now[:error] = 'Validation Errors'

    render :new
  end

  def update
    if resource.update resource_params
      flash.now[:success] = 'Update success'
    else
      flash.now[:error] = 'Validation Errors'
    end

    render :show
  end

  private
  def collection
    @collection ||= Compiler.all.order(:id).page(params[:page])
  end

  def resource
    @resource ||= Compiler.find params[:id]
  end

  def resource_params
    params.require(:compiler).permit(:name, :version, :time_a, :time_b, :memory_a, :memory_b, :status)
  end

  def initialize_resource
    @resource = Compiler.new
  end

  def build_resource
    @resource = Compiler.new resource_params
  end
end
