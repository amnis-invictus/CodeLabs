class TagsController < ApplicationController
  skip_before_action :authorize_collection

  private
  def collection
    @collection ||= Tag.all
  end
end
