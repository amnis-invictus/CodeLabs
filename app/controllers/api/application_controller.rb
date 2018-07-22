class Api::ApplicationController < ApplicationController
  skip_before_action :authorize_resource, :authorize_collection, :verify_authenticity_token

  before_action -> { response.status = 201 }, only: :create

  private
  def authenticate!
    head 401 unless params[:access_token] == ENV['API_ACCESS_TOKEN']
  end

  def default_url_options
    {}
  end

  def set_locale
    I18n.locale = :en
  end
end
