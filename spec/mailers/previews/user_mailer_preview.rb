class UserMailerPreview < ActionMailer::Preview
  def email
    UserMailer.email User.new username: 'test-username'
  end
end
