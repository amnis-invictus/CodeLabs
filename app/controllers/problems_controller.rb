class ProblemsController < ApplicationController
  skip_before_action :authenticate!, only: %i(index show)

  def create
    redirect_to resource and return if resource.save

    flash.now[:error] = 'Validation Errors'

    render :new
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

  def resource_params
    params.require(:problem).permit \
      :memory_limit, :time_limit, :real_time_limit, :checker_compiler_id, :checker_source, tag_ids: [],
      examples_attributes: %i(id input answer _destroy),
      tests_attributes: %i(id num input answer _destroy),
      translations_attributes: %i(id language caption author text technical_text default _destroy)
  end

  def initialize_resource
    @resource = Problem.new
  end

  def build_resource
    @resource = Problem.new resource_params
  end
end
