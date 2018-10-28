class ProblemsController < ApplicationController
  skip_before_action :authenticate!, only: %i(index show)

  def create
    redirect_to resource and return if resource.save

    flash.now[:error] = 'Validation Errors'

    render :new
  end

  def update
    redirect_to resource and return if resource.update resource_params

    flash.now[:error] = 'Validation Errors'

    render :edit
  end

  def destroy
    resource.destroy

    redirect_to :problems
  end

  private
  def collection
    @collection ||= problems.includes(:user).order(:id).page(params[:page])
  end

  def problems
    parent ? parent.problems : Problem.all
  end

  def parent
    @parent ||= \
      case
      when params[:tag_id]
        Tag.find params[:tag_id]
      when params[:user_id]
        User.find params[:user_id]
      when params[:group_id]
        Group.find params[:group_id]
      end
  end

  def resource
    @resource ||= Problem.find(params[:id]).decorate
  end

  def resource_params
    params.require(:problem).permit \
      :memory_limit, :time_limit, :real_time_limit, :checker_compiler_id, :checker_source, :private, tag_ids: [],
      examples_attributes: %i(id input answer _destroy),
      tests_attributes: %i(id num point input answer _destroy),
      translations_attributes: %i(id language caption author text technical_text default _destroy)
  end

  def initialize_resource
    @resource = current_user.problems.new
  end

  def build_resource
    @resource = current_user.problems.new resource_params
  end
end
