# Be sure to restart your server when you modify this file.

# Configure sensitive parameters which will be filtered from the log file.
Rails.application.config.filter_parameters += %i[
  password auth_token access_token passw secret token _key crypt salt certificate otp ssn
]
