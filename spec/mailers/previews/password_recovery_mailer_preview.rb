class PasswordRecoveryMailerPreview < ActionMailer::Preview
  def email
    PasswordRecoveryMailer.email User.new username: 'test-username', password_recovery_token: SecureRandom.uuid
  end
end
