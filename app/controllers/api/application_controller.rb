class Api::ApplicationController < ApplicationController
  # lgtm[rb/csrf-protection-disabled]
  skip_before_action :verify_authenticity_token

  before_action -> { response.status = 201 }, only: :create

  rescue_from(Pundit::NotAuthorizedError) { head 403 }

  private

  def authenticate!
    head 401 unless ActiveSupport::SecurityUtils.secure_compare params[:access_token] || '', ENV.fetch('API_ACCESS_TOKEN')
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
