class PasswordRecoveryMailer < ApplicationMailer
  def email user
    @user = user

    mail subject: 'Password recovery at CodeLabs', to: user.email
  end
end
