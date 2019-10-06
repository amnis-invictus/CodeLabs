require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  let(:user) { stub_model User, username: 'test', email: 'user@codelabs.site' }

  subject { described_class.email user }

  its(:subject) { should eq 'Successful registration at CodeLabs' }

  its(:from) { should eq ['no-reply@codelabs.site'] }

  its(:to) { should eq ['user@codelabs.site'] }
end
