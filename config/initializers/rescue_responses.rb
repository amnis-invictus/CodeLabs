Rails.application.configure do
  config.action_dispatch.rescue_responses['Pundit::NotAuthorizedError'] = :forbidden
end
