require "rails_helper"

RSpec.describe PasswordRecoveryMailer, type: :mailer do
  let(:user) { stub_model User, username: 'test', email: 'user@codelabs.site', password_recovery_token: SecureRandom.uuid }

  subject { described_class.email user }

  its(:subject) { should eq 'Password recovery at CodeLabs' }

  its(:from) { should eq [ENV['SMTP_FROM']] }

  its(:to) { should eq ['user@codelabs.site'] }
end
