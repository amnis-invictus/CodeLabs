class CompilersController < ApplicationController
  def create
    if resource.save
      flash[:success] = I18n.t 'flash.save.success'

      redirect_to :compilers
    else
      flash.now[:error] = I18n.t 'flash.save.failure'

      render :new, turbolinks: true
    end
  end

  def update
    if resource.update resource_params
      flash.now[:success] = I18n.t 'flash.save.success'
    else
      flash.now[:error] = I18n.t 'flash.save.failure'
    end

    render :edit, turbolinks: true
  end

  def destroy
    resource.destroy

    redirect_to :compilers
  end

  private

  def collection
    @collection ||= Compiler.order(:id).page(params[:page])
  end

  def resource
    @resource ||= Compiler.find params[:id]
  end

  def resource_params
    params.require(:compiler).permit(:name, :version, :time_a, :time_b, :memory_a, :memory_b, :status, :config)
  end

  def initialize_resource
    @resource = Compiler.new
  end

  def build_resource
    @resource = Compiler.new resource_params
  end
end
