class Api::ApplicationController < ApplicationController
  skip_before_action :set_locale, :authorize_resource, :authorize_collection

  before_action -> { response.status = 201 }, only: :create

  private
  def authenticate!
    head 401 unless params[:access_token] == ENV['API_ACCESS_TOKEN']
  end
end
