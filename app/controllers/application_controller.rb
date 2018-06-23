class ApplicationController < ActionController::Base
  include Pundit

  before_action :set_locale

  before_action :authenticate!

  before_action :initialize_resource, only: :new

  before_action :build_resource, only: :create

  before_action :authorize_resource, except: :index

  before_action :authorize_collection, only: :index

  helper_method :current_user, :parent, :collection, :resource

  private
  def current_user
    @current_user ||= {} # TODO
  end

  def authenticate!
    head 401 unless current_user
  end

  def authorize_resource
    authorize resource
  end

  def authorize_collection
    authorize collection
  end

  def set_locale
    I18n.locale = params[:language] if I18n.locale_available? params[:language]
  end
end
