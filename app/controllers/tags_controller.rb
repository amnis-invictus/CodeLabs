class TagsController < ApplicationController
  skip_before_action :authenticate!, only: :index

  private

  def collection
    @collection ||= Tag.order(problems_count: :desc).page(params[:page])
  end
end
