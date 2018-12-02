class TagsController < ApplicationController
  skip_before_action :authenticate!, only: :index

  private
  def collection
    @collection ||= Tag.all
  end
end
