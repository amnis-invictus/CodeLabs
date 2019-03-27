class ApplicationController < ActionController::Base
  include Pundit

  before_action :authenticate!, :set_locale

  before_action :initialize_resource, only: :new

  before_action :build_resource, only: :create

  before_action :authorize_resource, except: :index

  before_action :authorize_collection, only: :index

  helper_method :current_user, :parent, :collection, :resource

  rescue_from Pundit::NotAuthorizedError do
    flash[:error] = I18n.t 'flash.not_authorized'

    redirect_back fallback_location: :root, allow_other_host: false
  end

  private

  def current_user
    return unless cookies.encrypted[:auth_token]

    @current_user ||= User.joins(:auth_tokens).find_by(auth_tokens: { id: cookies.encrypted[:auth_token] })
  end

  def authenticate!
    unless current_user
      session[:redirect] = request.fullpath

      redirect_to [:new, :session]
    end
  end

  def authorize_resource
    authorize resource
  end

  def authorize_collection
    authorize collection
  end

  def set_locale
    I18n.locale = I18n.locale_available?(params[:language]) ? params[:language] : I18n.default_locale
  end

  def default_url_options
    { language: I18n.locale }
  end
end
