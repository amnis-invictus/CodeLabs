module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      reject_unauthorized_connection unless current_user
    end

    def current_user
      return unless cookies.encrypted[:auth_token]

      @current_user ||= User.joins(:auth_tokens).find_by(auth_tokens: { id: cookies.encrypted[:auth_token] })
    end
  end
end
