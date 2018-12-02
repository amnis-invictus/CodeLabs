class TagsController < ApplicationController
  private
  def collection
    @collection ||= Tag.all
  end
end
