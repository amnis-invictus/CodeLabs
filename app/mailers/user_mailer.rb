class UserMailer < ApplicationMailer
  def email user
    @user = user

    mail subject: 'Successful registration at CodeLabs', to: user.email
  end
end
