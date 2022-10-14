class Api::ApplicationController < ApplicationController
  skip_before_action :verify_authenticity_token

  before_action -> { response.status = 201 }, only: :create

  rescue_from(Pundit::NotAuthorizedError) { head 403 }

  private

  def authenticate!
    head 401 unless BCrypt::Password.valid_hash?(params[:access_token]) && valid_access_token?
  end

  def valid_access_token?
    password = BCrypt::Password.new params[:access_token]

    password.is_password?(ENV['API_ACCESS_TOKEN']) && $redis_workers.with { _1.set password.salt, nil, nx: true, ex: 24.hours.seconds }
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
