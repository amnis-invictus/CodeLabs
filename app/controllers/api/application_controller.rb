class Api::ApplicationController < ApplicationController
  #lgtm[rb/csrf-protection-disabled]
  skip_before_action :verify_authenticity_token # ; lgtm

  before_action -> { response.status = 201 }, only: :create

  rescue_from(Pundit::NotAuthorizedError) { head :forbidden }

  private

  def authenticate!
    return if ActiveSupport::SecurityUtils.secure_compare params[:access_token] || '', ENV.fetch('API_ACCESS_TOKEN')

    head :unauthorized
  end

  def current_user
    nil
  end

  def default_url_options
    {}
  end

  def set_locale
    I18n.locale = :en
  end
end
