class ProblemsController < ApplicationController
  skip_before_action :authenticate!, only: %i(index show)

  def create
    render :new and return unless resource.save

    redirect_to resource
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
      :memory_limit, :time_limit, :real_time_limit, :checker_compiler_id, :checker_source,
      examples_attributes: %i(input answer _destroy),
      tests_attributes: %i(num input answer _destroy),
      translations_attributes: %i(language caption author text technical_text _destroy)
  end

  def initialize_resource
    @resource = Problem.new
  end

  def build_resource
    @resource = Problem.new resource_params
  end
end
